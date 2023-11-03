require 'rails_helper'

RSpec.describe PriceCustomization, type: :model do
  describe '#no_date_overlap' do
    it 'inválido quando outro preço customizado cruzar com outras datas' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      PriceCustomization.create!(room: room, start_date: '2023-12-1', end_date: '2024-02-29', daily_rate: 400,
                                season: :high_season, season_name: 'Semana de Inverno')
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-12-30',
                                                  daily_rate: 200, season: :low_season, season_name: 'Semana de Menor Tráfego')

      expect(price_customization.valid?).to be_falsey
      expect(price_customization.errors.full_messages).to include('O intervalo de datas não pode se sobrepor a outros preços personalizados.')
    end

    it 'válido quando outro preço customizado NÂO cruzar com outras datas' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      PriceCustomization.create(room: room, start_date: '2023-12-1', end_date: '2024-02-29', daily_rate: 400,
                                season: :low_season, season_name: 'Semana de Inverno')
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-11-30', daily_rate: 200,
                                                  season: :low_season, season_name:  de Menor Tráfego')
      price_customization.valid?
      expect(price_customization.valid?).to be true
    end
  end

  describe '#date_end_is_later ' do
    it 'inválido quando data ínicio é posterior a data final' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-12-10', end_date: '2023-11-30', daily_rate: 200,
                                                  season: :low_season, season_name:  de Menor Tráfego')
      price_customization.valid?
      expect(price_customization.valid?).to be false
    end
  end

  describe '#valid?' do
     it 'inválido quando data ínicio não é passada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '', end_date: '2023-11-30', daily_rate: 200,
                                                  season: :low_season, season_name:  de Menor Tráfego')
      price_customization.valid?
      expect(price_customization.valid?).to be false
    end

    it 'inválido quando data final não é passada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '', daily_rate: 200,
                                                  season: :low_season, season_name:  de Menor Tráfego')
      price_customization.valid?
      expect(price_customization.valid?).to be false
    end

    it 'inválido quando diária personalizada não é passada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-11-30', daily_rate: '')
      price_customization.valid?
      expect(price_customization.valid?).to be false
    end

    it 'inválido quando Nome da Temporada não é passada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-11-30', daily_rate: 500,
                                                  season: :high_season, season_name: '')
      price_customization.valid?
      expect(price_customization.valid?).to be false
      expect(price_customization.errors.full_messages).to include('Nome da Temporada não pode ficar em branco')
    end

    it 'inválido quando Tipo de Temporada não é passada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-11-30', daily_rate: 500,
                                                  season: '', season_name: 'Inverno')
      price_customization.valid?
      expect(price_customization.valid?).to be false
      expect(price_customization.errors.full_messages).to include('Tipo de Temporada não pode ficar em branco')
    end
  end

  describe '#validate_daily_rate_for_high_season' do
    it 'inválido quando diária não tiver haver com temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-12-30',
                                                  daily_rate: 200, season: :high_season, season_name: 'Semana de Menor Tráfego')
      error_message = 'Diária Personalizada só pode ser menor que à Diária Padrão durante se for Temporada Baixa'
      expect(price_customization.valid?).to be_falsey
      expect(price_customization.errors.full_messages).to include(error_message)
    end

    it 'válido quando diária tiver haver com temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-12-30', daily_rate: 350,
                                                  season: :high_season, season_name: 'Semana de Menor Tráfego')
      expect(price_customization.valid?).to be true
    end
  end

  describe '#validate_daily_rate_for_low_season' do
    it 'inválido quando diária não tiver haver com temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-12-30', daily_rate: 350,
                                                  season: :low_season, season_name: 'Semana de Menor Tráfego')
      error_message = 'Diária Personalizada só pode ser maior que à Diária Padrão se for Temporada Alta'
      expect(price_customization.valid?).to be_falsey
      expect(price_customization.errors.full_messages).to include(error_message)
    end

    it 'válido quando diária tiver haver com temporada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                      registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                      address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                      city: 'Gramado', zip_code: ' 95670-000',
                                      description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                      payment_methods: 'Crédito e Débito', accepts_pets: true,
                                      usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

      room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                  daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                  tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
      price_customization = PriceCustomization.new(room: room, start_date: '2023-11-10', end_date: '2023-12-30', daily_rate: 230,
                                                  season: :low_season, season_name: 'Semana de Menor Tráfego')
      expect(price_customization.valid?).to be true
    end
  end
end
