require 'rails_helper'

describe 'Usuário registra uma reserva para um quarto' do
  it 'vẽ resumo da reserva' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    other_room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Bangalô Família')
    click_on('Reservar')

    fill_in 'Check in', with: '2023-11-14'
    fill_in 'Check out', with: '2023-11-17'
    fill_in 'Quantidade de Hóspedes', with: 3
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Informações Sobre Sua Reserva')
    expect(page).to have_content('Preço total de diárias: 1200')
    expect(page).to have_content('Check in: 14/11/2023 15:00')
    expect(page).to have_content('Check out: 17/11/2023 14:00')
    expect(page).to have_content('Quantidade de Hóspedes: 3')
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
    other_room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Bangalô Família')
    click_on('Reservar')

    fill_in 'Check in', with: '2023-11-14'
    fill_in 'Check out', with: '2023-11-17'
    fill_in 'Quantidade de Hóspedes', with: 3
    click_on 'Salvar'
    click_on 'Confirmar Reserva'

    # Assert
    expect(page).to have_content('Nova reserva registrada')
  end

  it 'e não está logado' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    other_room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')

    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Bangalô Família')
    click_on('Reservar')

    fill_in 'Check in', with: '2023-11-14'
    fill_in 'Check out', with: '2023-11-17'
    fill_in 'Quantidade de Hóspedes', with: 3
    click_on 'Salvar'
    click_on 'Confirmar Reserva'

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'e faz login para registrar reserva' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    other_room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(name: 'João Almeida',cpf: '11169382002', email: 'joao@email.com', password: 'password')

    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Bangalô Família')
    click_on('Reservar')

    fill_in 'Check in', with: '2023-11-14'
    fill_in 'Check out', with: '2023-11-17'
    fill_in 'Quantidade de Hóspedes', with: 3
    click_on 'Salvar'
    click_on 'Confirmar Reserva'
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    

    # Assert
    #expect(page).to have_content('Nova reserva registrada')
  end
end
