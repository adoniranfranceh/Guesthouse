require 'rails_helper'

describe 'Administrador altera status de uma reserva' do
   context 'para status active' do
     it 'e faz check in com sucesso' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      user = User.create!(name: 'João Almeida', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      RoomReservation.create!(user: user, room: room, check_in: Date.today, check_out: 2.day.from_now, number_of_guests: 4)

      # Act
      login_as(admin, scope: :admin)
      visit root_path
      click_on('Reservas')
      click_on('ABCD1234')
      travel_to Time.zone.local(2023, 11, 26, 16, 15, 00)
      click_on('Fazer check in')

      # Assert
      expect(page).to have_content('Reserva ativa com sucesso')
      expect(page).to have_content('Status: Ativo')
      expect(page).to have_content('Check in realizado em: 26/11/2023 16:15')
      expect(RoomReservation.last.status).to eq('active')
      travel_back
    end
  end

  context 'para status canceled' do
    it 'e cancela por atraso de check in com sucesso' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      user = User.create!(name: 'João Almeida', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      reservation = RoomReservation.create!(user: user, room: room, check_in:  2.days.ago, check_out: 2.day.from_now, number_of_guests: 4)

      # Act
      login_as(admin, scope: :admin)
      visit show_admin_room_reservations_path(room_id: room.id, id: reservation.id)
      click_on('Cancelar')

      # Assert
      expect(page).to have_content('Reserva cancelada com sucesso')
      expect(RoomReservation.last.status).to eq('canceled')
    end

    it 'e só pode cancelar com 2 dias depois da previsão de check in' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      user = User.create!(name: 'João Almeida', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      reservation = RoomReservation.create!(user: user, room: room, check_in:  1.days.ago, check_out: 2.day.from_now, number_of_guests: 4)

      # Act
      login_as(admin, scope: :admin)
      visit show_admin_room_reservations_path(room_id: room.id, id: reservation.id)

      # Assert
      expect(page).not_to have_button('Cancelar')
    end
  end

  context 'para status closed' do
    it 'e finaliza reserva com sucesso' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      user = User.create!(name: 'João Almeida', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
      reservation = RoomReservation.create!(user: user, room: room, check_in:  '2024-01-22', check_out: '2024-01-25', number_of_guests: 4,
                                            status: :active, guest_arrival: '2024-01-22 15:00:00')

      # Act
      login_as(admin, scope: :admin)
      visit actives_room_reservations_path
      click_on('ABCD1234')
      travel_to Time.zone.local(2024, 01, 24, 15, 40, 00)
      fill_in 'Meio de Pagamento Escolhido', with: 'Crédito'
      click_on('Fazer check out')

      # Assert
      expect(page).to have_content('Reserva finalizada com sucesso')
      expect(page).to have_content('Status: Finalizado')
      expect(page).to have_content('Total pago: 900')
      expect(page).to have_content('Check out realizado em: 24/01/2024 15:40')
      expect(page).to have_content('Meio de Pagamento Escolhido: Crédito')
      expect(RoomReservation.last.status).to eq('closed')
      travel_back
    end
  end
end
