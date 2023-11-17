require 'rails_helper'

describe 'Administrador altera status da reserva' do
  context 'fazer check in' do
    it 'e ainda não estiver na data do check in' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: 1.week.from_now, check_out: 2.week.from_now, number_of_guests: 5)

      # Act
      login_as(admin, scope: :admin)
      post(make_check_in_room_reservation_path(reservation.id))

      # Assert
      expect(response).to redirect_to root_path
      expect(RoomReservation.last.status).not_to eq('active')
    end

    it 'e não é dono' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: 2.day.ago, check_out: 2.week.from_now, number_of_guests: 5)

      # Act
      post(make_check_in_room_reservation_path(reservation.id))

      # Assert
      expect(response).to redirect_to root_path
      expect(RoomReservation.last.status).not_to eq('active')
    end
  end

  context 'cancelar reserva' do
    it 'e ainda não está 2 dias de atraso para check in' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: '2023-11-15',
                                            check_out: '2023-11-17', number_of_guests: 5)

      # Act
      login_as(admin, scope: :admin)
      travel_to Time.zone.local(2023, 11, 16, 14, 0, 23)
      post(cancel_admin_room_reservation_path(reservation.id))

      # Assert
      expect(response).to redirect_to root_path
      expect(RoomReservation.last.status).not_to eq('canceled')
      travel_back
    end

    it 'e não é dono' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: '2023-11-12',
                                            check_out: '2023-11-17', number_of_guests: 5)

      # Act
      travel_to Time.zone.local(2023, 11, 16, 15, 10, 00)
      post(cancel_admin_room_reservation_path(reservation.id))

      # Assert
      expect(response).to redirect_to root_path
      expect(RoomReservation.last.status).not_to eq('canceled')
      travel_back
    end
  end

  context 'fazer check out' do
    it 'se estiver pendente' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: 1.week.from_now,
                                            check_out: 2.week.from_now, number_of_guests: 5, status: :pending)

      # Act
      login_as(admin, scope: :admin)
      post(make_check_out_room_reservation_path(reservation.id))

      # Assert
      expect(response).to redirect_to root_path
      expect(RoomReservation.last.status).not_to eq('closed')
    end

    it 'e não é dono' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: '23-11-24',
                                            check_out: '23-11-26', number_of_guests: 5, status: :active)

      # Act
      travel_to Time.zone.local(2023, 11, 25, 15, 00, 00)
      post(make_check_out_room_reservation_path(reservation.id))

      # Assert
      expect(response).to redirect_to root_path
      expect(RoomReservation.last.status).not_to eq('closed')
      travel_back
    end
  end
end
