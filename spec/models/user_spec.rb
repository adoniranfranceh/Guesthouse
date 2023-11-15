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
  end
end
