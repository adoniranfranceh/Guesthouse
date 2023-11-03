require 'rails_helper'

describe 'Administrador edita pousada' do
  it 'a partir da tela inicial' do
  	# Arrange
  	admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    within('nav') do
    	click_on('Minha Pousada')
    end
    click_on('Editar')

    # Assert
    expect(page).to have_field('Nome Fantasia', with: 'Pousada Árvore da Coruja')
    expect(page).to have_field('Razão Social', with: 'Pousada Guest LTDA')
    expect(page).to have_field('CNPJ', with: '24469244000186')
    expect(page).to have_field('Telefone', with: '(99)91234-1234')
    expect(page).to have_field('E-mail', with: 'arvore@email.com.br')
    expect(page).to have_field('Endereço', with: 'Rua: Pedro Candiago, 725')
    expect(page).to have_field('Bairro', with: 'Planalto')
    expect(page).to have_field('Estado', with: 'RS')
    expect(page).to have_field('Cidade', with: 'Gramado')
    expect(page).to have_field('Descrição', with: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
    expect(page).to have_field('Formas de Pagamento', with: 'Crédito e Débito')
    expect(page).to have_checked_field('Aceita')
    expect(page).not_to have_checked_field('Não aceita')
    expect(page).to have_field('Políticas de Uso', with: 'Não é permitido fumar')
    expect(page).to have_field('Check in', with: '15:00:00.000')
    expect(page).to have_field('Check out', with: '14:00:00.000')
  end

  it 'com sucesso' do
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    within('nav') do
      click_on('Minha Pousada')
    end
    click_on('Editar')
    fill_in 'Check in', with: '15:30:00.000'
    fill_in 'Check out', with: '14:30:00.000'
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Pousada atualizada com sucesso')
    expect(page).to have_content('Check in: 15:30')
    expect(page).to have_content('Check out: 14:30')
  end

  it 'e não deixa campo em branco' do
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    within('nav') do
      click_on('Minha Pousada')
    end
    click_on('Editar')
    fill_in 'CNPJ', with: ''
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Pousada não atualizada')
  end

  it 'e torna ativa' do
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :inactive)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    within('nav') do
      click_on('Minha Pousada')
    end
    click_on('Tornar Ativa')

    # Assert
    expect(page).to have_content('Sua pousada está ativa')
  end

  it 'e torna inativa' do
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    within('nav') do
      click_on('Minha Pousada')
    end
    click_on('Tornar Inativa')

    # Assert
    expect(page).to have_content('Sua pousada está inativa')
  end
end
