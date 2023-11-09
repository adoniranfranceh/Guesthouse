require 'rails_helper'

describe 'Administrador registra um quarto' do
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
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Minha Pousada')
    click_on('Adicionar novo quarto')
    fill_in 'Título', with: 'Chalé de 1 Quarto'
    fill_in 'Descrição', with: 'Camas confortáveis'
    fill_in 'Área do Quarto', with: '40'
    fill_in 'Capacidade Máxima', with: '4'
    fill_in 'Diária Padrão', with: '300'
    check 'Banheiro Privado'
    check 'Varanda'
    check 'Ar Condicionado'
    check 'TV'
    check 'Guarda-Roupa'
    check 'Cofre Disponível'
    check 'Acessível para PcD'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Chalé de 1 Quarto')
    expect(page).to have_content('Área do Quarto: 40m²')
    expect(page).to have_content('Camas confortáveis')
    expect(page).to have_content('Ocupação Máxima: 4')
    expect(page).not_to have_content('Não há quartos disponíveis')
  end

  it 'e não preenche campos' do
      # Arrange
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
    click_on('Minha Pousada')
    click_on('Adicionar novo quarto')
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    click_on('Salvar')

    # Assert
    expect(page).to have_content('Quarto não foi registrado')
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Área do Quarto não pode ficar em branco')
    expect(page).to have_content('Capacidade Máxima não pode ficar em branco')
    expect(page).to have_content('Diária Padrão não pode ficar em branco')
  end
end
