class Inn < ApplicationRecord
  belongs_to :admin
  has_many :rooms
  has_many :room_reservations, through: :rooms
  validates :brand_name, :corporate_name, :registration_number, :phone,
            :email, :address, :neighborhood, :state, :city, :zip_code, :description,
            :payment_methods, :usage_policies, :check_in, :check_out, presence: true
  validates :accepts_pets, inclusion: { in: [true, false] }
  validates :registration_number, uniqueness: true
  enum status: { inactive: 0, active: 5 }

  def full_description
    "#{self.corporate_name} - #{self.registration_number}"
  end

  scope :search_for_inns, ->(term) do
    where('inns.neighborhood LIKE ? OR inns.city LIKE ? OR inns.brand_name LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%")
  end
end
