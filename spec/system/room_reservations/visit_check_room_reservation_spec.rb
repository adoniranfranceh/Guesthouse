require 'rails_helper'

describe 'Visitante vê reservas de um quarto' do
  it 'e abre formulário' do
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
    click_on('Pousada Árvore da Coruja')
    click_on('Chalé de 1 Quarto')
    click_on('Reservar')

    #Assert
    expect(page).to have_content('Faça uma Reserva')  
    expect(page).to have_content('Chalé de 1 Quarto')  
    expect(page).to have_content('Área do Quarto: 40m²')
    expect(page).to have_content('Capacidade Máxima: 4')
    expect(page).to have_content('Diária Padrão: R$ 300,00')
    expect(page).to have_content('Banheiro Privado')
    expect(page).to have_content('Varanda')
    expect(page).to have_content('TV')
    expect(page).to have_content('Guarda-Roupa')
    expect(page).to have_content('Cofre Disponível')
    expect(page).to have_content('Acessível para PcD')
    expect(page).to have_content('Camas confortáveis')

    expect(page).to have_field('Check in')
    expect(page).to have_field('Check out')
    expect(page).to have_field('Quantidade de Hóspedes')
  end

  it 'e vê detalhes da reserva com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    other_room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(email: 'joao@email.com', password: 'password')
    RoomReservation.create!(user: user, room: other_room, check_in: '2023-11-17', check_out: '2023-11-25', number_of_guests: 4)

    room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    price_customization = PriceCustomization.create!(room: room, start_date: '2023-11-17',
                                                    end_date: '2023-12-30', daily_rate: 400,
                                                    season: :high_season, season_name: 'Fim de Ano')


    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Chalé de 1 Quarto')
    click_on('Reservar')

    fill_in 'Check in', with: '2023-11-14'
    fill_in 'Check out', with: '2023-11-17'
    fill_in 'Quantidade de Hóspedes', with: 3
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Informações Sobre Sua Reserva')
    expect(page).to have_content('Preço total de diárias: 1300')
    expect(page).to have_content('Check in: 14/11/2023 15:00')
    expect(page).to have_content('Check out: 17/11/2023 14:00')
    expect(page).to have_content('Quantidade de Hóspedes: 3')
  end

  it 'e reserva está ocupada' do
     # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(email: 'joao@email.com', password: 'password')
    RoomReservation.create!(user: user, room: room, check_in: 1.week.from_now, check_out: 2.week.from_now, number_of_guests: 4)

    Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Bangalô Família')
    click_on('Reservar')

    check_in = 8.day.from_now
    check_out = 2.week.from_now

    fill_in 'Check in', with: check_in
    fill_in 'Check out', with: check_out
    fill_in 'Quantidade de Hóspedes', with: 4
    click_on 'Salvar'

    # Assert
    expect(page).to have_content("Reserva não disponível entre #{I18n.localize(check_in.to_date)} e #{I18n.localize(check_out.to_date)}")
  end
end
