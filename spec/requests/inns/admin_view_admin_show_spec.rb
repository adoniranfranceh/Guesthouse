require 'rails_helper'

describe 'Administrador vê detalhes de uma pousada' do
  it 'e não é dono' do
    # Arrange
    admin = Admin.create!(name: 'Jorge', email: 'admin@email.com', password: 'password')
    other_admin = Admin.create!(name: 'Jorge', email: 'jorge@email.com', password: 'password')

    guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    # Act
    login_as(other_admin, scope: :admin)
    get(admin_show_inn_path(guesthouse.id))
    # Assert
    expect(response).to redirect_to root_path
  end
end
