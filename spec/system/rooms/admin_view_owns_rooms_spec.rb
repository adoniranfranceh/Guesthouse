require 'rails_helper'

describe 'Administrador vê seus próprios quartos' do
  it 'a partir da tela inicial' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    other_admin = Admin.create!(name: 'Chandler', email: 'chandler@email.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    
    other_guesthouse = Inn.create!(admin: other_admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                              registration_number: '65560651000181', phone: '(99)91235-1234', email: 'sun@email.com.br',
                              address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                              city: 'Gramado', zip_code: ' 95670-000',
                              description: 'Pousada nascer do sol oferece vista para o mar.',
                              payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                              usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00')

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    Room.create!(inn: other_guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Minha Pousada')

    # Assert
    expect(page).to have_content('Chalé de 1 Quarto')  
    expect(page).to have_content('Área do Quarto: 40m²')
    expect(page).not_to have_content('Bangalô Família')
    expect(page).not_to have_content('Área do Quarto: 35m²')
  end
end