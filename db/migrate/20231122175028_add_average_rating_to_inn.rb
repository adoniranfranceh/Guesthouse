class AddAverageRatingToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :average_rating, :float
  end
end
