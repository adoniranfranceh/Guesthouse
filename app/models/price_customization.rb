class PriceCustomization < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :daily_rate, presence: true

  validate :no_date_overlap, :date_end_is_later

  private

  def date_end_is_later
    if self.start_date.present? && self.end_date.present? && self.start_date >= self.end_date
      errors.add(:end_date, 'não pode ser anterior ou igual à data de início')
    end
  end


  def no_date_overlap
    return nil unless room.present?
    overlapping_customizations = room.price_customizations.where.not(id: self.id).where(
      "(? <= end_date) AND (? >= start_date)",
      self.start_date, self.end_date
    )

    if overlapping_customizations.exists?
      self.errors.add(:base, "O intervalo de datas não pode se sobrepor a outros preços personalizados.")
    end
  end
end
