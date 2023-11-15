require 'rails_helper'

describe 'Usuário vê detalhes de uma reserva' do
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
    RoomReservation.create!(user: user, room: room, check_in: '2023-11-17', check_out: '2023-11-18', number_of_guests: 4)
    
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on('Minhas Reservas')
    click_on('Bangalô Família')
    # Assert
    expect(page).to have_content('Reserva')
    expect(page).to have_content('Check in: 17/11/2023 15:00')
    expect(page).to have_content('Check out: 18/11/2023 14:00')
    expect(page).to have_content('Quantidade de Hóspedes: 4')
  end
end
