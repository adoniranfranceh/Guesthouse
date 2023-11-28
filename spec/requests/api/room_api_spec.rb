require 'rails_helper'

describe 'Room API' do
  context 'GET /api/v1/inns/1/rooms' do
    it 'Lista todos os quartos de uma pousada' do
    	# Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                  max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)

      # Act
      get('/api/v1/inns/1/rooms')

      # Assert
      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response[0]["title"]).to eq("Chalé de 1 Quarto")
      expect(json_response[1]["title"]).to eq("Bangalô Família")
    end

    it 'lista vazia por pousada está inativa' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :inactive)

      Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                  max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)

      # Act
      get('/api/v1/inns/1/rooms')

      # Assert
      expect(response.status).to eq(404)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(0)
    end

    it 'lista vazia por pousada não possuir quartos cadastrados ou disponível para reserva' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                  max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)

      # Act
      get('/api/v1/inns/1/rooms')

      # Assert
      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end
  end

  context 'GET /api/v1/rooms/1/room_reservations/available' do
    it 'valor total da reserva com disponibilidade' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                  max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)

      # Act
      get('/api/v1/rooms/1/room_reservations/available', params: { check_in: '2023-11-23', check_out: '2023-11-25',
                                                                   number_of_guests: 6 })

      # Assert
      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      expect(json_response["total"]).to eq(900)
      expect(json_response["status"]).to eq("disponível")
    end

    it 'reserva não disponível' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)
      RoomReservation.create!(user: user, room: room, check_in: '2023-11-23', check_out: '2023-11-26', number_of_guests: 2,
                              status: :pending)

      # Act
      get('/api/v1/rooms/1/room_reservations/available', params: { check_in: '2023-11-23', check_out: '2023-11-25',
                                                                   number_of_guests: 6 })

      # Assert
      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      expect(json_response["status"]).to eq("não disponível")
    end

    it 'qualquer campo em branco' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)
      RoomReservation.create!(user: user, room: room, check_in: '2023-11-23', check_out: '2023-11-26', number_of_guests: 2,
                              status: :pending)

      # Act
      get('/api/v1/rooms/1/room_reservations/available', params: { check_in: '2023-11-23', check_out: '2023-11-25',
                                                                   number_of_guests: '' })

      # Assert
      expect(response.status).to eq(400)
      json_response = JSON.parse(response.body)
      expect(json_response["info"]).to eq("Preencha todos os campos corretamente")
    end

    it 'formato inválido de data' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)
      RoomReservation.create!(user: user, room: room, check_in: '2023-11-23', check_out: '2023-11-26', number_of_guests: 2,
                              status: :pending)

      # Act
      get('/api/v1/rooms/1/room_reservations/available', params: { check_in: '2023-11-23', check_out: '2023-11',
                                                                   number_of_guests: '' })

      # Assert
      expect(response.status).to eq(400)
      json_response = JSON.parse(response.body)
      expect(json_response["info"]).to eq("Formato de data inválido")
    end
  end
end
