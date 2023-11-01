require 'rails_helper'

describe 'Visitante vê quartos' do
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

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
    	          daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: false, 
    	          tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    visit root_path
    click_on('Quartos Disponíveis')
    # Assert
    expect(page).to have_content('Quartos Disponíveis')
    expect(page).to have_content('Chalé de 1 Quarto')
    expect(page).to have_content('Área do Quarto: 40m²')
    expect(page).to have_content('Camas confortáveis')
    expect(page).to have_content('Ocupação Máxima: 4')
    expect(page).not_to have_content('Não há quartos disponíveis')
  end

  it 'e não existe' do
  	# Arrange 
  	# Act
    visit root_path
    click_on('Quartos Disponíveis')
    # Assert
    expect(page).to have_content('Não há quartos disponíveis')
  end
end
