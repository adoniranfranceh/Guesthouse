require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#current_price_customization' do
    it 'o dia atual está dentro de uma temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
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
      price_customization = PriceCustomization.create!(room: room, start_date: Date.today.yesterday,
                                                      end_date: 1.week.from_now, daily_rate: 200,
                                                      season: :low_season, season_name: 'Semana de Inverno')
      # Act
      result = room.current_price_customization
      # Assert
      expect(result).to eq(price_customization)
    end

    it 'o dia atual não está dentro de uma temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
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
      price_customization = PriceCustomization.create!(room: room, start_date: 1.week.from_now,
                                                      end_date: 1.month.from_now, daily_rate: 200,
                                                      season: :low_season, season_name: 'Mês de Inverno')
      # Act
      result = room.current_price_customization
      # Assert
      expect(result).to eq(nil)
    end
  end

  describe '#current_daily_rate' do
    it 'o dia atual está dentro de uma temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
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
      price_customization = PriceCustomization.create!(room: room, start_date: Date.today.yesterday,
                                                      end_date: 1.week.from_now, daily_rate: 200,
                                                      season: :low_season, season_name: 'Inverno Intenso')
      # Act
      result = room.current_daily_rate
      # Assert
      expect(result).to eq(200)
    end

    it 'o dia atual está dentro de uma temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
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
      price_customization = PriceCustomization.create!(room: room, start_date: 1.week.from_now,
                                                      end_date: 1.month.from_now, daily_rate: 200,
                                                      season: :low_season, season_name: 'Semana de Menor Tráfego')
      # Act
      result = room.current_daily_rate
      # Assert
      expect(result).to eq(300)
    end
  end
end
