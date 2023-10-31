require 'rails_helper'

RSpec.describe Inn, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando nome fantasia estiver em branco' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.new(admin: admin, brand_name: '', corporate_name: 'Pousada Guest LTDA',
                          registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                          address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                          city: 'Gramado', zip_code: ' 95670-000',
                          description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                          payment_methods: 'Crédito e Débito', accepts_pets: true,
                          usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
      expect(guesthouse.valid?).to be_falsey
      end
      it 'inválido quando razão social estiver em branco' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.new(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: '',
                          registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                          address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                          city: 'Gramado', zip_code: ' 95670-000',
                          description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                          payment_methods: 'Crédito e Débito', accepts_pets: true,
                          usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
      expect(guesthouse.valid?).to be_falsey
      end
      it 'inválido quando cnpj em branco' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.new(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                          registration_number: '', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                          address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                          city: 'Gramado', zip_code: ' 95670-000',
                          description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                          payment_methods: 'Crédito e Débito', accepts_pets: true,
                          usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
      expect(guesthouse.valid?).to be_falsey
      end
      it 'inválido quando telefone estiver em branco' do
      admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
      guesthouse = Inn.new(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                          registration_number: '24469244000186', phone: '', email: 'arvore@email.com.br',
                          address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                          city: 'Gramado', zip_code: ' 95670-000',
                          description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                          payment_methods: 'Crédito e Débito', accepts_pets: true,
                          usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
      expect(guesthouse.valid?).to be_falsey
      end
    end
    context 'uniqueness' do
      it 'false quando cnpj se repetir' do
        admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
        guesthouse = Inn.create(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvore@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00')
        other_guesthouse = Inn.new(admin: admin, brand_name: 'Pousada Nascer do', corporate_name: 'Sun LTDA',
                            registration_number: '24469244000186', phone: '(99)91235-1234', email: 'sun@email.com.br',
                            address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada nascer do sol oferece vista para o mar.',
                            payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                            usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00')
        expect(other_guesthouse.valid?).to be_falsey
      end
    end
  end
end
