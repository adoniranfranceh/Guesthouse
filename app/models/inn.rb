class Inn < ApplicationRecord
  belongs_to :admin

  def full_description
    "#{self.corporate_name} - #{self.registration_number}"
  end
end
