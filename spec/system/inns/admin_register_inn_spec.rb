require 'rails_helper'

describe 'Administrador registra pousada' do
  it 'a partir da tela inicial' do
    # Arrange
    roger = Admin.create!(name: 'Roger', email: 'roger@email.com', password: 'password')

    # Act
    login_as(roger, scope: :admin)
    visit root_path
    click_on('Cadastrar Pousada')
    fill_in 'Nome Fantasia', with: 'Pousada Árvore da Coruja'
    fill_in 'Razão Social', with: 'Pousada Guest LTDA'
    fill_in 'CNPJ', with: '24469244000186'
    fill_in 'Telefone', with: '(99)91234-1234'
    fill_in 'Endereço', with: 'Rua: Pedro Candiago, 725'
    fill_in 'E-mail', with: 'arvore@email.com.br'
    fill_in 'Bairro', with: 'Planalto'
    fill_in 'Cidade', with: 'Gramado'
    fill_in 'Estado', with: 'RS'
    fill_in 'CEP', with: '95670-000'
    fill_in 'Descrição', with: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.'
    fill_in 'Formas de Pagamento', with: 'Crédito e Débito'
    choose('Aceita', allow_label_click: true)
    fill_in 'Políticas de Uso', with: 'Não é permitido fumar'
    fill_in 'Check in', with: '15:00'
    fill_in 'Check out', with: '14:00'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Pousada registrada com sucesso')
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Pousada Guest LTDA - 24469244000186')
    expect(page).to have_content('Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
    expect(page).to have_content('Bairro: Planalto')
    expect(page).to have_content('Rua: Pedro Candiago, 725, Gramado, CEP 95670-000 - RS')
    expect(page).to have_content('Formas de Pagamento: Crédito e Débito')
    expect(page).to have_content('Não é permitido fumar')
    expect(page).to have_content('Check in: 15:00')
    expect(page).to have_content('Check out: 14:00')
    expect(page).to have_content('Entrada de Pets: Aceita')
    expect(page).to have_content('E-mail: arvore@email.com.br')
    expect(page).to have_content('Telefone: (99)91234-1234')
    expect(page).not_to have_content('Cadastrar Pousada')
  end

  it 'com dados incompletos' do
    # Arrange
    roger = Admin.create!(name: 'Roger', email: 'roger@email.com', password: 'password')

    # Act
    login_as(roger, scope: :admin)
    visit root_path
    click_on('Cadastrar Pousada')
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).not_to have_content('Pousada registrada com sucesso')
    expect(page).to have_content('Pousada não foi registrada')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Telefone não pode ficar em branco')
  end
end
