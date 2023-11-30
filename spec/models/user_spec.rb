require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it 'false quando o nome e cpf não for passado' do
      # Arrange
      user = User.new(name: '', email: 'user@user.com', password: 'password')
      # Act
      # Assert
      expect(user.valid?).to be_falsey
    end

    it 'false quando o cpf for inválido' do
      # Arrange
      user = User.new(name: 'User', cpf: '123123123', email: 'user@user.com', password: 'password')
      # Act
      # Assert
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include('CPF inválido')
    end

    it 'false quando cpf já estiver sido cadastrado' do
      User.create(name: 'André', cpf: '11169382002', email: 'andrejp@email.com', password: 'password')
      user = User.new(name: 'Claúdia', cpf: '11169382002', email: 'claudia@email.com', password: 'password')

      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to include('CPF já está em uso')
    end
  end
end
