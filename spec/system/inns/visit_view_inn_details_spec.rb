require 'rails_helper'
  
describe 'Visitante vê detalhes da pousada' do
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
  	visit root_path
    click_on('Pousada Árvore da Coruja')
  	# Assert
    expect(page).to have_content('Pousada Árvore da Coruja')
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
    expect(page).not_to have_content('Não existem pousadas cadastradas')
  end

  it 'E não está logado' do
    # Arrange
    admin = Admin.create!(name: 'Jorge', email: 'jorge@admin.com', password: 'password')
    other_admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

    # Act
    login_as(other_admin, scope: :admin)
    visit root_path
    click_on('Pousada Árvore da Coruja')
    # Assert
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
    expect(page).to have_content('Bairro: Planalto')
    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Tornar Ativa')
    expect(page).not_to have_link('Tornar Inativa')
  end
end
