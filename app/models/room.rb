class Room < ApplicationRecord
  belongs_to :inn
  has_many :price_customizations
  enum for_reservations: { available: 0, unavailable: 5 }
  validates :title, :description, :dimension, :max_occupancy, :daily_rate, presence: true

  def current_price_customization
    date_current_customized = price_customizations.find_by('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    if date_current_customized.present?
      date_current_customized
    end
  end

  def current_daily_rate
    return daily_rate if current_price_customization.nil?
    current_price_customization.daily_rate
  end
end
