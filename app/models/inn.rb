class Inn < ApplicationRecord
  belongs_to :admin

  validates :brand_name, :corporate_name, :registration_number, :phone,
            :email, :address, :neighborhood, :state, :city, :zip_code, :description,
            :payment_methods, :usage_policies, :check_in, :check_out, presence: true
  validates :accepts_pets, inclusion: { in: [true, false] }

  validates :registration_number, uniqueness: true

  enum status: { inactive: 0, active: 5 }

  def full_description
    "#{self.corporate_name} - #{self.registration_number}"
  end
end
