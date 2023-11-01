require 'rails_helper'

describe 'Visitante vê detalhes de um quarto' do
  it 'a partir da tela inicial com todos os campos preenchidos' do
  	 # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
    	          daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
    	          tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    visit root_path
    click_on('Quartos Disponíveis')
    click_on('Chalé de 1 Quarto')

    # Assert
    expect(page).to have_content('Quartos Disponíveis')
    expect(page).to have_content('Chalé de 1 Quarto')  
    expect(page).to have_content('Área do Quarto: 40m²')
    expect(page).to have_content('Capacidade Máxima: 4')
    expect(page).to have_content('Diária Padrão: R$ 300,00')
    expect(page).to have_content('Banheiro Privado')
    expect(page).to have_content('Varanda')
    expect(page).to have_content('TV')
    expect(page).to have_content('Guarda-Roupa')
    expect(page).to have_content('Cofre Disponível')
    expect(page).to have_content('Acessível para pessoas com deficiência')
    expect(page).to have_content('Camas confortáveis')
  end

  it 'a partir da tela inicial sem tv, ar condicionado e cofre' do
     # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: false, 
                tv: false, wardrobe: true, safe_available: '', accessible_for_disabled: true, for_reservations: :available)
    # Act
    visit root_path
    click_on('Quartos Disponíveis')
    click_on('Chalé de 1 Quarto')

    # Assert
    expect(page).to have_content('Quartos Disponíveis')
    expect(page).to have_content('Chalé de 1 Quarto')  
    expect(page).to have_content('Área do Quarto: 40m²')
    expect(page).to have_content('Capacidade Máxima: 4')
    expect(page).to have_content('Diária Padrão: R$ 300,00')
    expect(page).to have_content('Banheiro Privado')
    expect(page).to have_content('Varanda')
    expect(page).not_to have_content('TV')
    expect(page).to have_content('Guarda-Roupa')
    expect(page).not_to have_content('Ar Condicionado')
    expect(page).not_to have_content('Cofre Disponível')
    expect(page).to have_content('Acessível para pessoas com deficiência')
    expect(page).to have_content('Camas confortáveis')
  end
end