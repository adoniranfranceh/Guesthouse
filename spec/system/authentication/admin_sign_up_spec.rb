require 'rails_helper'

describe 'Administrador criar uma conta' do
  it 'com sucesso' do
  	# Arrange
  	# Act
  	visit root_path
  	click_on('Cadastrar Pousada')
  	click_on('Criar Administrador')
  	fill_in 'Nome', with: 'Jorge'
  	fill_in 'E-mail', with: 'jorge@admin.com'
  	fill_in 'Senha', with: 'password'
  	fill_in 'Confirme sua senha', with: 'password'
  	click_on('Criar')

  	expect(page).to have_content('Olá! Você realizou seu registro com sucesso.')
  	expect(Admin.last.name).to eq('Jorge')
  end

  it 'e não deve ter campos em brancos' do
  	# Arrange
  	# Act
  	visit root_path
  	click_on('Cadastrar Pousada')
  	click_on('Criar Administrador')
  	fill_in 'Nome', with: ''
  	fill_in 'E-mail', with: ''
  	fill_in 'Senha', with: ''
  	fill_in 'Confirme sua senha', with: ''
  	click_on('Criar')

    # Assert
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
