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
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

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

  it 'e pousada não está ativa' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvere@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                            registration_number: '38214597000140', phone: '(99)91235-1234', email: 'sun@email.com.br',
                            address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada nascer do sol oferece vista para o mar.',
                            payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                            usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :inactive)
    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Pousadas')
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
    expect(page).to have_content('Gramado')
    expect(page).not_to have_content('Pousada Nascer do Sol')
  end
end
