require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid' do
  	it 'false quando o nome não for passado' do
      # Arrange
      admin = Admin.new(name: '', email: 'admin@admin.com', password: 'password')
      # Act
  		
      # Assert
      expect(admin.valid?).to be_falsey
    end
  end
end
