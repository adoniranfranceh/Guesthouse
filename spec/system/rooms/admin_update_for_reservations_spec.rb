require 'rails_helper'

describe 'Administrador altera reservas de um quarto' do
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

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
    	          daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
    	          tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Minha Pousada')
    click_on('Chalé de 1 Quarto')
    click_on('Habilitar reserva')

    # Assert
    expect(page).to have_content('Quarto habilitado para reservas')
    expect(page).to have_content('Disponível para reservas')
    expect(page).not_to have_content('Habilitar reserva')
    expect(page).to have_content('Desabilitar reserva')
  end

  it 'e desabilita' do
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
    Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
    	          max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Minha Pousada')
    click_on('Chalé de 1 Quarto')
    click_on('Desabilitar reserva')
    click_on('Quartos Disponíveis')

    # Assert
    expect(page).to have_content('Bangalô Família')
    expect(page).not_to have_content('Chalé de 1 Quarto')
  end

  it 'e não está logado' do
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
    visit root_path
    click_on('Quartos Disponíveis')
    click_on('Chalé de 1 Quarto')

    # Assert
    expect(page).not_to have_content('Habilitar reserva')
    expect(page).not_to have_content('Desabilitar reserva')
    expect(page).not_to have_content('Editar')
  end
end
