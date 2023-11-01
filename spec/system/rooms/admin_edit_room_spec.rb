require 'rails_helper'

describe 'Administrador edita um quarto' do
  it 'A partir da tela inicial' do
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
    	          tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Quartos Disponíveis')
    click_on('Chalé de 1 Quarto')
    click_on('Editar')

    # Assert
    expect(page).to have_field('Título', with: 'Chalé de 1 Quarto')
    expect(page).to have_field('Descrição', with: 'Camas confortáveis')
    expect(page).to have_field('Capacidade Máxima', with: '4')
    expect(page).to have_field('Diária Padrão', with: '300')
    expect(page).to have_checked_field('Banheiro Privado')
    expect(page).to have_checked_field('Varanda')
    expect(page).to have_checked_field('Ar Condicionado')
    expect(page).not_to have_checked_field('TV')
    expect(page).to have_checked_field('Guarda-Roupa')
    expect(page).to have_checked_field('Cofre')
    expect(page).to have_checked_field('Acessível para pessoas com deficiência')
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

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Quartos Disponíveis')
    click_on('Chalé de 1 Quarto')
    click_on('Editar')
    uncheck('Ar Condicionado')
    uncheck('Cofre')
    click_on('Salvar')
    #Assert
    expect(page).not_to have_content('Ar Condicionado')
    expect(page).not_to have_content('Cofre')
  end
end
