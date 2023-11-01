class PriceCustomization < ApplicationRecord
  belongs_to :room

  validate :no_date_overlap

  private

  def no_date_overlap
    overlapping_customizations = room.price_customizations.where.not(id: self.id).where(
      "(? <= end_date) AND (? >= start_date)",
      self.start_date, self.end_date
    )

    if overlapping_customizations.exists?
      self.errors.add(:base, "O intervalo de datas não pode se sobrepor a outros preços personalizados.")
    end
  end
end
