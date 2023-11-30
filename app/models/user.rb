class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_is_valid

  has_many :room_reservations

  def cpf_is_valid
    require "cpf_cnpj"
    if CPF.valid?(self.cpf).nil?
      self.errors.add(:cpf, "inválido")
    end
  end
end
