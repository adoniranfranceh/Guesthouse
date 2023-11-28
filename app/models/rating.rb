class Rating < ApplicationRecord
  belongs_to :room_reservation
  belongs_to :user
  has_many :review_responses

  validates :grade, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  after_save :calc_average_rating_of_inn

  private

  def calc_average_rating_of_inn
    sum_of_grades = room_reservation.room.inn.ratings.sum(:grade)
    quantity_of_reservations = room_reservation.room.inn.room_reservations.count
    calc_media = sum_of_grades.to_f / quantity_of_reservations.to_f
    room_reservation.room.inn.update(average_rating: calc_media)
  end
end
