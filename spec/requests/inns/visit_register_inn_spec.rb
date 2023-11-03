require 'rails_helper'

describe 'Visitante cria pousada' do
	context '#new' do
    it 'e não é logado' do
      # Arrange

      # Act
      get(new_inn_path)
      # Assert
      expect(response).to redirect_to new_admin_session_path
    end
  end

  context '#create' do
    it 'e não é logado' do
      # Arrange

      # Act
      post(inns_path)
      # Assert
      expect(response).to redirect_to new_admin_session_path
    end
  end
end