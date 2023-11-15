require 'rails_helper'

RSpec.describe RoomReservation, type: :model do
  describe '#there_is_a_reservation_for_that_date' do
    it 'e quarto está ocupado para o intervalo de dias' do
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
      RoomReservation.create!(user: user, room: room, check_in: 1.week.from_now, check_out: 2.week.from_now, number_of_guests: 4)
      reservation = RoomReservation.new(user: user, room: room, check_in: 10.day.from_now, check_out: 2.week.from_now, number_of_guests: 4)
      # Act
      # Assert
      result = reservation.valid?

      expect(result).to be false
    end

    it 'e quarto não está ocupado para o intervalo de dias' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      other_room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      joao = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      RoomReservation.new(user: joao, room: other_room, check_in: 10.day.from_now, check_out: 2.week.from_now, number_of_guests: 4)

      marcos = User.create!(name: 'Marcos Alcântara', cpf: '83041333007', email: 'marcos@email.com', password: 'password')
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                  max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      reservation = RoomReservation.create!(user: marcos, room: room, check_in: 1.week.from_now, check_out: 2.week.from_now, number_of_guests: 4)

      # Act
      result = room.valid?

      # Assert
      expect(result).to be true
    end
  end

  describe '#valid' do
    it 'false se check_in estiver em branco' do
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
      reservation = RoomReservation.new(user: user, room: room, check_in: '', check_out: 2.week.from_now, number_of_guests: 4)
      # Act
      # Assert
      result = reservation.valid?

      expect(result).to be false
    end

    it 'false se check_out estiver em branco' do
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
      reservation = RoomReservation.new(user: user, room: room, check_in: 1.week.from_now, check_out: '', number_of_guests: 4)
      # Act
      # Assert
      result = reservation.valid?

      expect(result).to be false
    end

    it 'false se número de hóspedes em branco' do
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
      reservation = RoomReservation.new(user: user, room: room, check_in: 1.week.from_now, check_out: 2.week.from_now, number_of_guests: '')
      # Act
      # Assert
      result = reservation.valid?

      expect(result).to be false
    end
  end

  describe '#guest_limit' do
    it 'false se a quantidade de pessoas for maior do que o permitido' do
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
      reservation = RoomReservation.new(user: user, room: room, check_in: 1.week.from_now, check_out: 2.week.from_now, number_of_guests: 8)

      result = reservation.valid?

      expect(result).to be false
      expect(reservation.errors.full_messages).to include('Quantidade de Hóspedes não pode ser maior do que 6 pessoas')
    end
  end
end
