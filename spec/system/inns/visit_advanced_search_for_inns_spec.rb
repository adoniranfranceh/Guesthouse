require 'rails_helper'

describe 'Visitante faz busca avançada de pousadas' do
  it 'e busca pousadas que aceitam pets' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                            registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                            address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                            city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                            description: 'Pousada de frente para o rio.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)94444-1234', email: 'arvere@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)

    # Act
    visit root_path
    within('nav') do
      click_on 'Busca Avançada'
    end
    click_on 'Aceita Pets'
    
    # Assert
    expect(page).to have_content('Pousada Boa Vista')
    expect(page).to have_content('Pousada Árvore da Coruja')

  end

  it 'e busca pousadas que tenham quartos com tv' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                            registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                            address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                            city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                            description: 'Pousada de frente para o rio.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)94444-1234', email: 'arvere@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)

    # Act
    visit root_path
    within('nav') do
      click_on 'Busca Avançada'
    end
    click_on 'TV'
    
    # Assert
    expect(page).not_to have_content('Pousada Boa Vista')
    expect(page).not_to have_content('Pousada Árvore da Coruja')
  end

  it 'e busca pousadas que tenham quartos com ar condicionado' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                            registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                            address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                            city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                            description: 'Pousada de frente para o rio.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)94444-1234', email: 'arvere@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true,
                tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :unavailable)

    # Act
    visit root_path
    within('nav') do
      click_on 'Busca Avançada'
    end
    click_on 'Ar Condicionado'
    
    # Assert
    expect(page).to have_content('Pousada Boa Vista')
    expect(page).not_to have_content('Pousada Árvore da Coruja')
  end
end
