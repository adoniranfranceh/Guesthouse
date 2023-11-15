class RoomReservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :check_in, :check_out, :number_of_guests, presence: true
  validate :there_is_a_reservation_for_that_date, on: :confirm, on: :create
  validate :guest_limit

  before_save :total_daily_rates_to_reserve

  def there_is_a_reservation_for_that_date
    room_reservation = self.room.room_reservations.find_by('? <= check_out AND ? >= check_in', self.check_in, self.check_out)
    if room_reservation.present?
      self.errors.add(:base, "Reserva não disponível entre #{I18n.l(check_in.to_date)} e #{I18n.l(check_out.to_date)}")
    end
  end

  def guest_limit
    if self.room.present? && self.number_of_guests.present? && self.number_of_guests > self.room.max_occupancy
      self.errors.add(:number_of_guests, "não pode ser maior do que #{self.room.max_occupancy} pessoas")
    end
  end

  def total_daily_rates_to_reserve
    self.total_daily_rates = self.room.total_price(self.check_in, self.check_out)
  end
end
