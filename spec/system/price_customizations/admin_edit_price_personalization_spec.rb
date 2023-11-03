require 'rails_helper'

describe 'Administrador edita preço personalizado para quarto' do
  it 'a partir da tela inicial' do
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
    price_customization = PriceCustomization.create!(room: room, season_name: 'Fim de Ano', start_date: '2023-11-10',
                                                    end_date: '2023-12-30', daily_rate: 200, season: :low_season)

    # Act
    login_as(admin, scope: :admin)
    visit inn_room_path(inn_id: guesthouse.id, id: room.id)
    click_on('Fim de Ano')

    # Assert
    expect(page).to have_content('Editar Preço Customizado')
    expect(page).to have_field('Data Início', with: '2023-11-10')
    expect(page).to have_field('Nome da Temporada', with: 'Fim de Ano')
    expect(page).to have_checked_field('Baixa Temporada')
    expect(page).to have_field('Data Final', with: '2023-12-30')
    expect(page).to have_field('Diária Personalizada', with: '200')
  end

  it 'com sucesso' do
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
    price_customization = PriceCustomization.create!(room: room, season_name: 'Fim de Ano', start_date: '2023-11-10',
                                                    end_date: '2023-12-30', daily_rate: 200, season: :low_season)

    # Act
    login_as(admin, scope: :admin)
    visit inn_room_path(inn_id: guesthouse.id, id: room.id)
    click_on('Fim de Ano')
    fill_in('Data Início', with: '2023-11-15')
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Preço customizado atualizado com sucesso')
    expect(page).to have_content('De 15/11/2023 a 30/12/2023, a partir de 200')
  end
end
