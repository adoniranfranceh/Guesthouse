# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')

inn = Inn.create!(
  admin: admin,
  brand_name: 'Pousada Vila Mar',
  corporate_name: 'VVMM LTDA',
  registration_number: '24469244000186',
  phone: '(99)91234-1234',
  email: 'vilamar@email.com.br',
  address: 'Rua: Pedro Candiago, 725',
  neighborhood: 'Planalto',
  state: 'RS',
  city: 'Gramado',
  zip_code: '95670-000',
  description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
  payment_methods: 'Crédito e Débito',
  accepts_pets: true,
  usage_policies: 'Não é permitido fumar',
  check_in: '15:00',
  check_out: '14:00',
  status: :active
)
inn.inn_photos.attach(io: File.open(Rails.root.join('spec/fixtures/files/pousada.png')), filename: 'inn_image.jpg')

room = Room.create!(
  inn: inn,
  title: 'Bangalô Família',
  description: 'Com vista para o rio e barcos de pesca',
  dimension: 35,
  max_occupancy: 6,
  daily_rate: 300,
  private_bathroom: true,
  balcony: false,
  air_conditioning: true,
  tv: true,
  wardrobe: true,
  safe_available: true,
  accessible_for_disabled: true,
  for_reservations: :available
)
room.room_photos.attach(io: File.open(Rails.root.join('spec/fixtures/files/quarto.jpeg')), filename: 'room_image.jpg')

second_room = Room.create!(
  inn: inn,
  title: 'Suíte Executiva',
  description: 'Vista panorâmica para a cidade',
  dimension: 40,
  max_occupancy: 7,
  daily_rate: 450,
  private_bathroom: true,
  balcony: true,
  air_conditioning: true,
  tv: true,
  wardrobe: true,
  safe_available: true,
  accessible_for_disabled: true,
  for_reservations: :available
)
second_room.room_photos.attach(io: File.open(Rails.root.join('spec/fixtures/files/suíte.png')), filename: 'second_room_image.jpg')

user = User.create!(name: 'João', cpf: '11169382002', email: 'joao@email.com', password: 'password')

reservation = RoomReservation.create!(
  user: user,
  room: room,
  check_in: 3.days.ago,
  check_out: 1.day.ago,
  number_of_guests: 4,
  status: :closed
)

rating = Rating.create(grade: 5, comment: 'Adorei a estadia', room_reservation: reservation, user: user)
