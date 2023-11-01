require 'rails_helper'

describe 'Administrador registra um quarto' do
  context 'e não é dono' do
    it '#create' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      other_admin = Admin.create!(name: 'Carlos', email: 'carlos@admin.com', password: 'password')

      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
      	          daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
      	          tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)

      # Act
      login_as(other_admin, scope: :admin)
      post(inn_rooms_path(inn_id: guesthouse.id, id: room.id), params: { room: { inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available }})

      # Asset
      expect(response).to redirect_to root_path
    end

    it '#new' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      other_admin = Admin.create!(name: 'Carlos', email: 'carlos@admin.com', password: 'password')

      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                  tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)

      # Act
      login_as(other_admin, scope: :admin)
      get(new_inn_room_path(inn_id: guesthouse.id))

      # Asset
      expect(response).to redirect_to root_path
    end
  end
end
