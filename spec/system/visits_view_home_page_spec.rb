require 'rails_helper'

describe 'Visitantes entram na página principal' do
  it 'com sucesso' do
  	# Arrange

  	# Act
  	visit root_path

  	# Assert
  	expect(page).to have_content('Pousadas')
  end
end
