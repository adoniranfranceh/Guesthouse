class RoomReservation < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :check_in, :check_out, :number_of_guests, :total_daily_rates, :code, presence: true
  validate :there_is_a_reservation_for_that_date, on: [:create, :confirm]
  validate :guest_limit

  before_validation :total_daily_rates_to_reserve
  before_validation :generate_code, on: :create

  enum status: { canceled: 0, pending: 5, in_progress: 10 }

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

  def less_than_7_days_to_check_in?
    days_remaining_to_check_in = self.check_in - Date.today
    days_remaining_to_check_in < 7
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def total_daily_rates_to_reserve
    if check_in.present? && check_out.present?
      return self.total_daily_rates = self.room.total_price(self.check_in, self.check_out)
    end
  end
end
