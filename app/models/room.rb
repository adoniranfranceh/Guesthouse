class Room < ApplicationRecord
  belongs_to :inn
  has_many :price_customizations
  has_many :room_reservations
  enum for_reservations: { available: 0, unavailable: 5 }
  validates :title, :description, :dimension, :max_occupancy, :daily_rate, presence: true

  def current_price_customization
    date_current_customized = price_customizations.find_by('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    if date_current_customized.present?
      date_current_customized
    end
  end

  def total_price(check_in, check_out)
    total_price = 0

    (check_in..check_out).each do |date|
        daily_rate = current_daily_rate(date: date)
        total_price += daily_rate
    end

    total_price
  end

  def current_daily_rate(date: Date.today)
    date_customization = price_customizations.find_by('start_date <= ? AND end_date >= ?', date, date)
    return date_customization.daily_rate if date_customization.present?
    daily_rate
  end
end
