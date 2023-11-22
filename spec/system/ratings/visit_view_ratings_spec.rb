require 'rails_helper'

describe 'Visitante vê avaliações' do
  it 'média de uma pousada' do
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
    joao = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
    reservation_of_joao = RoomReservation.create!(user: joao, room: room, check_in: 6.days.ago, check_out: 5.day.ago,
                                                  number_of_guests: 4, status: :closed)
    carlos = User.create!(name: 'Carlos', cpf: '42712837037', email: 'carlos@email.com', password: 'password')
    reservation_of_carlos = RoomReservation.create!(user: carlos, room: room, check_in: 4.days.ago, check_out: 3.days.ago,
                                                    number_of_guests: 3, status: :closed)
    andre = User.create!(name: 'André', cpf: '70518763099', email: 'andre@email.com', password: 'password')
    reservation_of_andre = RoomReservation.create!(user: andre, room: room, check_in: 2.days.ago, check_out: 1.days.ago,
                                                   number_of_guests: 1, status: :closed)
    rating = Rating.create!(grade: 5, comment: 'Adorei a estadia', room_reservation: reservation_of_joao, user: joao)
    rating = Rating.create!(grade: 3, comment: 'Achei regular', room_reservation: reservation_of_carlos, user: carlos)
    rating = Rating.create!(grade: 3, comment: 'Não pude ficar o tempo todo', room_reservation: reservation_of_andre, user: andre)
    # Act
    visit root_path
    click_on('Pousada Árvore da Coruja')

    # Assert
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Nota Média: 3.6')
  end
end
