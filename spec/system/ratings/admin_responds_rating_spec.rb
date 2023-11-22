require 'rails_helper'

describe 'Administrador responde avaliação' do
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
    room = Room.create!(inn: guesthouse, title: 'Bangalô Família', description: 'Com vista para o rio e barcos de pesca', dimension: 35,
                max_occupancy: 6, daily_rate: 300, private_bathroom: true, balcony: false, air_conditioning: true,
                tv: true, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
    reservation = RoomReservation.create!(user: user, room: room, check_in: 3.days.ago, check_out: 1.day.ago, number_of_guests: 4,
                                status: :closed)
    Rating.create(grade: 5, comment: 'Adorei a estadia', room_reservation: reservation, user: user)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    click_on('Avaliações')
    click_on('Avaliado por: João')

    # Assert
    expect(page).to have_content('Avaliado por: João')
    expect(page).to have_content('Nota: 5')
    expect(page).to have_content('Comentário: Adorei a estadia')
    expect(page).to have_field('Responder João')
    expect(page).to have_button('Responder')
  end

  it 'com sucesso' do
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
    user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
    reservation = RoomReservation.create!(user: user, room: room, check_in: 3.days.ago, check_out: 1.day.ago, number_of_guests: 4,
                                status: :closed)
    rating = Rating.create(grade: 5, comment: 'Adorei a estadia', room_reservation: reservation, user: user)

    # Act
    login_as(admin, scope: :admin)
    visit show_admin_rating_path(rating.id)
    fill_in 'Responder João', with: 'Obrigado pelo seu feedback João, ficamos felizes em te receber'
    click_on('Responder')
  end
end
