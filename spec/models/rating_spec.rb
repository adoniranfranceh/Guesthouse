require 'rails_helper'

RSpec.describe Rating, type: :model do
  context '.valid?' do
    it 'false quando nota for maior do que 5' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: 3.days.ago, check_out: 1.day.ago, number_of_guests: 4,
                                  status: :closed)
      rating = Rating.new(grade: 6, comment: 'Adorei a estadia', room_reservation: reservation, user: user)

      expect(rating.valid?).to be false
    end

    it 'false quando nota for menor do que 0' do
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
      user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')
      reservation = RoomReservation.create!(user: user, room: room, check_in: 3.days.ago, check_out: 1.day.ago, number_of_guests: 4,
                                  status: :closed)
      rating = Rating.new(grade: -1, comment: 'Adorei a estadia', room_reservation: reservation, user: user)

      expect(rating.valid?).to be false
    end
  end
end
