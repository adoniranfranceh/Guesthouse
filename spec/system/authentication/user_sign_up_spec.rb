require 'rails_helper'

describe 'Usuário cria uma conta' do
  it 'com sucesso' do
  	# Arrange
  	# Act
  	visit root_path
  	click_on('Entre ou registre-se')
  	click_on('Registre-se')
  	fill_in 'Nome', with: 'André'
  	fill_in 'E-mail', with: 'andré@campuscode.com'
    fill_in 'CPF', with: '11169382002'
  	fill_in 'Senha', with: 'password'
  	fill_in 'Confirme sua senha', with: 'password'
  	click_on('Criar')

  	expect(page).to have_content('Olá! Você realizou seu registro com sucesso.')
  	expect(User.last.name).to eq('André')
  end

  it 'e não deve ter campos em brancos' do
  	# Arrange
  	# Act
  	visit root_path
  	click_on('Entre ou registre-se')
  	click_on('Registre-se')
  	fill_in 'Nome', with: ''
  	fill_in 'E-mail', with: ''
  	fill_in 'Senha', with: ''
  	fill_in 'Confirme sua senha', with: ''
  	click_on('Criar')

    # Assert
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
