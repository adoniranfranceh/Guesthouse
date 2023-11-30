require 'rails_helper'

describe 'Administrador adiciona Foto para um quarto de sua pousada' do
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
    room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available)
    # Act
    login_as(admin, scope: :admin)
    visit edit_inn_room_path(inn_id: guesthouse.id, id: room.id)
    attach_file 'Adicionar Fotos', Rails.root.join('spec/fixtures/files/quarto.jpeg')
    click_on 'Salvar'

    # Assert
    expect(page).to have_content('Quarto atualizado com sucesso')
    expect(page).to have_css('img')
  end

  it 'e exclui' do
  	# Arrange
  	room_img = Rails.root.join('spec/fixtures/files/quarto.jpeg')
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    room = Room.create!(inn: guesthouse, title: 'Chalé de 1 Quarto', description: 'Camas confortáveis', dimension: 40 , max_occupancy: 4,
                daily_rate: 300, private_bathroom: true, balcony: true, air_conditioning: true, 
                tv: false, wardrobe: true, safe_available: true, accessible_for_disabled: true, for_reservations: :available,
                room_photos: room_img)
    # Act
    login_as(admin, scope: :admin)
    visit inn_room_path(inn_id: guesthouse.id, id: room.id)
    click_on 'Excluir'

    # Assert
    expect(page).to have_content('Foto excluída com sucesso')
    expect(page).not_to have_css('img')
  end
end
