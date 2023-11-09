require 'rails_helper'

describe 'Visitante vê preço customizado' do
  it 'a partir da tela inicial' do
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
    price_customization = PriceCustomization.create!(room: room,start_date: Date.today,
                                                    end_date: 1.week.from_now, daily_rate: 400,
                                                    season: :high_season, season_name: 'Fim de Ano')
    # Act
    visit root_path
    click_on('Quartos Disponíveis')

    # Assert
    expect(page).not_to have_content('Alta Temporada de Fim de Ano')
    expect(page).not_to have_content('A partir de R$ 400,00')
  end

  it 'e possui uma pousada' do
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
    price_customization = PriceCustomization.create!(room: room,start_date: Date.today,
                                                    end_date: 1.week.from_now, daily_rate: 400,
                                                    season: :high_season, season_name: 'Fim de Ano')
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Minha Pousada')
    click_on('Chalé de 1 Quarto')

    # Assert
    expect(page).to have_content('Alta Temporada de Fim de Ano')
    expect(page).to have_content('A partir de R$ 400,00')
  end
end