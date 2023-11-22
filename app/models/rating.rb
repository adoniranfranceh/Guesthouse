class Rating < ApplicationRecord
  belongs_to :room_reservation
  belongs_to :user
  has_many :review_responses
end
