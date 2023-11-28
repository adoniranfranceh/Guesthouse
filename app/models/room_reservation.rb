class RoomReservation < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :rating

  validates :check_in, :check_out, :number_of_guests, :total_daily_rates, :code, presence: true
  validate :unavailable_for_date?, on: [:create, :confirm, :available]
  validate :guest_limit, :check_out_is_later

  before_validation :total_daily_rates_to_reserve
  before_validation :generate_code, on: :create
  after_save :guest_arrival_when_check_in
  after_save :guest_departure_when_check_out

  enum status: { canceled: 0, pending: 5, active: 10, closed: 15 }

  def unavailable_for_date?
    room_reservations = self.room.room_reservations.where('? <= check_out AND ? >= check_in', self.check_in, self.check_out)
                                                  .where.not(status: :canceled)

    if room_reservations.present?
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

  def reservation_if_check_in
    Date.today >= self.check_in
  end

  def two_days_late_for_check_in?
    days_of_delay = Date.today - self.check_in
    days_of_delay >= 2
  end

  def guest_departure_when_check_out
    if status == 'closed' && guest_departure.nil? && guest_arrival.present?
      self.update(guest_departure: Time.zone.now, paid: room.total_price(guest_arrival.to_date, Time.zone.now))
    end
  end

  private

  def check_out_is_later
    if self.check_in.present? && self.check_out.present? && self.check_in > self.check_out
      self.errors.add(:base, 'O Check in deve ser menor que o Check out')
    end
  end

  def guest_arrival_when_check_in
    if status == 'active' && guest_arrival.nil?
      update(guest_arrival: Time.current)
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def total_daily_rates_to_reserve
    if check_in.present? && check_out.present?
      return self.total_daily_rates = self.room.total_price(self.check_in, self.check_out)
    end
  end
end
