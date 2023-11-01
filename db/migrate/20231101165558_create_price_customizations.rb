class CreatePriceCustomizations < ActiveRecord::Migration[7.1]
  def change
    create_table :price_customizations do |t|
      t.references :room, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :daily_rate

      t.timestamps
    end
  end
end
