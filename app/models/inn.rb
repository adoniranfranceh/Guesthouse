class Inn < ApplicationRecord
  belongs_to :admin

  validates :brand_name, :corporate_name, :registration_number, :phone,
            :email, :address, :neighborhood, :state, :city, :zip_code, :description,
            :payment_methods, :accepts_pets, :usage_policies, :check_in, :check_out, presence: true
  validates :registration_number, uniqueness: true

  def full_description
    "#{self.corporate_name} - #{self.registration_number}"
  end
end
