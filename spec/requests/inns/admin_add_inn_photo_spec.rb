require 'rails_helper'

describe 'Administrador adiciona Foto para sua pousada' do
  it 'e não é dono' do
  	# Arrange
    inn_img = Rails.root.join('spec/fixtures/files/pousada.png')
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    other_admin = Admin.create!(name: 'Roger', email: 'roger@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active,
                                    inn_photos: inn_img)
    # Act
    login_as(other_admin, scope: :admin)
    delete(delete_photo_inn_path(id: guesthouse.id, photo_id: guesthouse.inn_photos.last.id))

    # Assert
    expect(response).to redirect_to root_path
  end

  it 'com sucesso' do
    # Arrange
    inn_img = Rails.root.join('spec/fixtures/files/pousada.png')
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    other_admin = Admin.create!(name: 'Roger', email: 'roger@admin.com', password: 'password')
    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                                    registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                                    address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                                    city: 'Gramado', zip_code: ' 95670-000',
                                    description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                                    payment_methods: 'Crédito e Débito', accepts_pets: true,
                                    usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active,
                                    inn_photos: inn_img)
    # Act
    login_as(admin, scope: :admin)
    delete(delete_photo_inn_path(id: guesthouse.id, photo_id: guesthouse.inn_photos.last.id))

    # Assert
    expect(response).to have_http_status(302)
  end
end
