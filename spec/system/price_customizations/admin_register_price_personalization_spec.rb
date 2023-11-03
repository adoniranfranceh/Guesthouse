require 'rails_helper'

describe 'Administrador registra preço personalizado para quarto' do
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
    # Act
    login_as(admin, scope: :admin)
    visit inn_room_path(inn_id: guesthouse.id, id: room.id)
    click_on('Adicionar personalização preço')

    # Assert
    expect(page).to have_content('Novo Preço Customizado')
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
    # Act
    login_as(admin, scope: :admin)
    visit inn_room_path(inn_id: guesthouse.id, id: room.id)
    click_on('Adicionar personalização preço')
    fill_in 'Nome da Temporada', with: 'Fim de Ano'
    choose 'Alta Temporada'
    fill_in 'Data Início', with: '2023-09-11'
    fill_in 'Data Final', with: '2024-02-29'
    fill_in 'Diária Personalizada', with: '400'
    click_on('Salvar')
    # Assert
    expect(page).to have_content('Preço customizado registrado com sucesso')
    expect(page).to have_content('De 11/09/2023 a 29/02/2024, a partir de 400')
    expect(page).to have_content 'Alta Temporada de Fim de Ano'
  end
end
