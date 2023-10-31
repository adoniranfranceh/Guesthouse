require 'rails_helper'

describe 'Administrador se autentuca' do
  it 'com sucesso' do
  	# Arrange
    admin = Admin.create!(name: 'admin', email: 'admin@admin.com', password: 'password')

  	# Act
  	visit root_path
  	click_on('Cadastrar Pousada')
  	fill_in 'E-mail', with: 'admin@admin.com'
  	fill_in 'Senha', with: 'password'
  	click_on('Entrar')

  	# Assert
  	expect(page).to have_content('Login efetuado com sucesso')
  end

  it 'e faz logout' do
    # Arrange
    admin = Admin.create!(name: 'admin', email: 'admin@admin.com', password: 'password')
    
    # Act
    login_as admin
    visit root_path
    click_on('Sair')

    # Assert
    expect(page).to have_content('Logout efetuado com sucesso')
  end
end
