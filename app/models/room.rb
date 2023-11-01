class Room < ApplicationRecord
  belongs_to :inn
  enum for_reservations: { available: 0, unavailable: 5 }
end
