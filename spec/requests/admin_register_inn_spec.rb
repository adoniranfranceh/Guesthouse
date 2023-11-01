require 'rails_helper'

describe 'Administrador registra pousada' do
  context 'new' do
  it 'mas já possui uma' do
    # Arrange
     admin = Admin.create!(name: 'Jorge', email: 'jorge@email.com', password: 'password')
     guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      # Act
      login_as(admin, scope: :admin)
      get(new_inn_path)
      # Assert
      expect(response).to redirect_to root_path
    end
  end

  context 'create' do
    it 'mas já possui uma' do
      # Arrange
      admin = Admin.create!(name: 'Jorge', email: 'jorge@email.com', password: 'password')
      guesthouse = Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      # Act
      login_as(admin, scope: :admin)
      post(inns_path)
      # Assert
      expect(response).to redirect_to root_path
    end
  end
end
