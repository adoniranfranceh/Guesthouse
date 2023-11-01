class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.references :inn, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :dimension
      t.integer :max_occupancy
      t.integer :daily_rate
      t.boolean :private_bathroom
      t.boolean :balcony
      t.boolean :air_conditioning
      t.boolean :tv
      t.boolean :wardrobe
      t.boolean :safe_available
      t.boolean :accessible_for_disabled
      t.integer :for_reservations, default: 0

      t.timestamps
    end
  end
end
