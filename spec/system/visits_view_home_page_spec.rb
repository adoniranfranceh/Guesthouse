require 'rails_helper'

describe 'Visitante entram na página principal' do
  it 'e vê pousadas' do
  	# Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvere@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')

  	# Act
  	visit root_path

  	# Assert
  	expect(page).to have_content('Pousadas')
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
    expect(page).to have_content('Gramado')
    expect(page).not_to have_content('Não existem pousadas cadastradas')
  end

  it 'e não existem pousadas' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Não existem pousadas cadastradas')
  end
end
