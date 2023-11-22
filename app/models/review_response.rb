class ReviewResponse < ApplicationRecord
  belongs_to :rating
  validates :comment, presence: true
end
