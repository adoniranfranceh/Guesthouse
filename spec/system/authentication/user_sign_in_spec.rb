require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
  	# Arrange
    user = User.create!(name: 'João Almeida', cpf: '11169382002' ,email: 'joao@campuscode.com', password: 'password')

  	# Act
  	visit root_path
  	click_on('Entre ou registre-se')
  	fill_in 'E-mail', with: 'joao@campuscode.com'
  	fill_in 'Senha', with: 'password'
  	click_on('Entrar')

  	# Assert
  	expect(page).to have_content('Login efetuado com sucesso')
  end

  it 'e faz logout' do
    # Arrange
    user = User.create!(name: 'João Almeida', cpf: '11169382002' ,email: 'joão@campuscode.com', password: 'password')
    
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Sair')

    # Assert
    expect(page).to have_content('Logout efetuado com sucesso')
  end
end
