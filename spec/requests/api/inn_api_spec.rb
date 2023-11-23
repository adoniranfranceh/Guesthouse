require 'rails_helper'

describe 'Inn API' do
	context 'GET /api/v1/inns' do
    it 'lista todas as pousadas ativas' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                  registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                  address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                  city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                  description: 'Pousada de frente para o rio.',
                  payment_methods: 'Crédito e Débito', accepts_pets: true,
                  usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                  registration_number: '24469244000186', phone: '(99)94444-1234', email: 'arvere@email.com.br',
                  address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                  city: 'Gramado', zip_code: ' 95670-000',
                  description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                  payment_methods: 'Crédito e Débito', accepts_pets: true,
                  usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                  registration_number: '38214597000140', phone: '(99)91999-1234', email: 'sun@email.com.br',
                  address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                  city: 'Gramado', zip_code: ' 95670-000',
                  description: 'Pousada nascer do sol oferece vista para o mar.',
                  payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                  usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :active)
      # Act
      get('/api/v1/inns')

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
      expect(json_response[0]["brand_name"]).to eq('Pousada Boa Vista')
      expect(json_response[1]["brand_name"]).to eq('Pousada Árvore da Coruja')
      expect(json_response[2]["brand_name"]).to eq('Pousada Nascer do Sol')
    end

    it 'retorna empty se tiver pousadas ativas' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                  registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                  address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                  city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                  description: 'Pousada de frente para o rio.',
                  payment_methods: 'Crédito e Débito', accepts_pets: true,
                  usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :inactive)
      # Act
      get('/api/v1/inns')

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(0)
      expect(json_response).to eq([])
    end
  end

  context 'GET /api/v1/inns/search' do
    it 'lista resultado de busca por nome da pousada' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                  registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                  address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                  city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                  description: 'Pousada de frente para o rio.',
                  payment_methods: 'Crédito e Débito', accepts_pets: true,
                  usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                  registration_number: '24469244000186', phone: '(99)94444-1234', email: 'arvere@email.com.br',
                  address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                  city: 'Gramado', zip_code: ' 95670-000',
                  description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                  payment_methods: 'Crédito e Débito', accepts_pets: true,
                  usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
      Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                  registration_number: '38214597000140', phone: '(99)91999-1234', email: 'sun@email.com.br',
                  address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                  city: 'Gramado', zip_code: ' 95670-000',
                  description: 'Pousada nascer do sol oferece vista para o mar.',
                  payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                  usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :active)
      # Act
      get('/api/v1/inns/search', params: { query: 'Nascer do Sol' })

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["brand_name"]).to eq('Pousada Nascer do Sol')
    end

    it 'e não há resultados para a busca' do
      # Arrange
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                  registration_number: '38214597000140', phone: '(99)91999-1234', email: 'sun@email.com.br',
                  address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                  city: 'Gramado', zip_code: ' 95670-000',
                  description: 'Pousada nascer do sol oferece vista para o mar.',
                  payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                  usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :inactive)
      # Act
      get('/api/v1/inns/search', params: { query: 'Nascer do Sol' })

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 0
      expect(json_response).to eq([])
    end
  end
end
