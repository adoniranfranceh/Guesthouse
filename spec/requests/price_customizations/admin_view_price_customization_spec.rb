require 'rails_helper'

describe 'Administrador edita preço customizado' do
  context '#edit' do
    it 'e não é dono' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      other_admin = Admin.create!(name: 'Jorge', email: 'jorge@email.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40,
                          max_occupancy: 4, daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.create!(room: room, start_date: '2023-11-10', end_date: '2023-12-30', daily_rate: 200,
                                                      season: :low_season, season_name: 'Inverno')
      # Act
      login_as(other_admin, scope: :admin)
      get(edit_inn_room_price_customization_path(inn_id: guesthouse.id,
                                                room_id: room,
                                                id: price_customization))
      # Assert
      expect(response).to redirect_to root_path
    end
  end

  context '#update' do
    it 'e não é dono' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      other_admin = Admin.create!(name: 'Jorge', email: 'jorge@email.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                              registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                              address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                              payment_methods: 'Crédito e Débito', accepts_pets: true,
                              usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40,
                          max_occupancy: 4, daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.create!(room: room, start_date: '2023-11-10', end_date: '2023-12-30', daily_rate: 200,
                                                      season: :low_season, season_name: 'Inverno')
      # Act
      login_as(other_admin, scope: :admin)
      patch(inn_room_price_customization_path(inn_id: guesthouse.id,
                                                room_id: room,
                                                id: price_customization))
      # Assert
      expect(response).to redirect_to root_path
    end
	end
end