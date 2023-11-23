require 'rails_helper'

describe 'Visitante vê avaliações' do
  it 'de nota média de uma pousada' do
    # Arrange
    admin = Admin.create!(name: 'Carlos', email: 'carlos@admin.com', password: 'password')
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
    roger = User.create!(name: 'Roger', cpf: '52609458088', email: 'roger@email.com', password: 'password')
    reservation_of_roger = RoomReservation.create!(user: roger, room: room, check_in: 16.days.ago, check_out: 13.day.ago,
                                                   number_of_guests: 2, status: :closed)
    joao = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
    reservation_of_joao = RoomReservation.create!(user: joao, room: room, check_in: 6.days.ago, check_out: 5.day.ago,
                                                  number_of_guests: 4, status: :closed)
    carlos = User.create!(name: 'Carlos', cpf: '42712837037', email: 'carlos@email.com', password: 'password')
    reservation_of_carlos = RoomReservation.create!(user: carlos, room: room, check_in: 4.days.ago, check_out: 3.days.ago,
                                                    number_of_guests: 3, status: :closed)
    andre = User.create!(name: 'André', cpf: '70518763099', email: 'andre@email.com', password: 'password')
    reservation_of_andre = RoomReservation.create!(user: andre, room: room, check_in: 2.days.ago, check_out: 1.days.ago,
                                                   number_of_guests: 1, status: :closed)
    Rating.create!(grade: 4, comment: 'Adorei a estadia', room_reservation: reservation_of_roger, user: roger)
    Rating.create!(grade: 5, comment: 'Adorei a estadia', room_reservation: reservation_of_joao, user: joao)
    Rating.create!(grade: 3, comment: 'Achei regular', room_reservation: reservation_of_carlos, user: carlos)
    Rating.create!(grade: 3, comment: 'Não pude ficar o tempo todo', room_reservation: reservation_of_andre, user: andre)
    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')

    # Assert
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Nota Média: 3.8')
    expect(page).to have_content('Últimas avaliações')
    expect(page).to have_content('Avaliado por: João')
    expect(page).to have_content('Avaliado por: Carlos')
    expect(page).to have_content('Avaliado por: André')
    expect(page).not_to have_content('Avaliado por: Roger')
    expect(page).to have_link('Ver todas as avaliações')
  end

  it 'e vê avaliações' do
    # Arrange
    admin = Admin.create!(name: 'Carlos', email: 'carlos@admin.com', password: 'password')
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
    roger = User.create!(name: 'Roger', cpf: '52609458088', email: 'roger@email.com', password: 'password')
    reservation_of_roger = RoomReservation.create!(user: roger, room: room, check_in: 16.days.ago, check_out: 13.day.ago,
                                                   number_of_guests: 2, status: :closed)
    joao = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
    reservation_of_joao = RoomReservation.create!(user: joao, room: room, check_in: 6.days.ago, check_out: 5.day.ago,
                                                  number_of_guests: 4, status: :closed)
    carlos = User.create!(name: 'Carlos', cpf: '42712837037', email: 'carlos@email.com', password: 'password')
    reservation_of_carlos = RoomReservation.create!(user: carlos, room: room, check_in: 4.days.ago, check_out: 3.days.ago,
                                                    number_of_guests: 3, status: :closed)
    andre = User.create!(name: 'André', cpf: '70518763099', email: 'andre@email.com', password: 'password')
    reservation_of_andre = RoomReservation.create!(user: andre, room: room, check_in: 2.days.ago, check_out: 1.days.ago,
                                                   number_of_guests: 1, status: :closed)
    Rating.create!(grade: 4, comment: 'Adorei a estadia', room_reservation: reservation_of_roger, user: roger)
    Rating.create!(grade: 5, comment: 'Adorei a estadia', room_reservation: reservation_of_joao, user: joao)
    Rating.create!(grade: 3, comment: 'Achei regular', room_reservation: reservation_of_carlos, user: carlos)
    Rating.create!(grade: 3, comment: 'Não pude ficar o tempo todo', room_reservation: reservation_of_andre, user: andre)
    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')
    click_on('Ver todas as avaliações')

    # Assert
    expect(page).to have_content('Avaliações da Pousada Árvore da Coruja')
    expect(page).to have_content('Avaliado por: João')
    expect(page).to have_content('Avaliado por: Carlos')
    expect(page).to have_content('Avaliado por: André')
    expect(page).to have_content('Avaliado por: Roger')
  end
end
