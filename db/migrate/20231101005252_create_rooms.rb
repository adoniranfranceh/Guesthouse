class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.references :inn, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :dimension
      t.integer :max_occupancy
      t.integer :daily_rate
      t.boolean :private_bathroom, default: false
      t.boolean :balcony, default: false
      t.boolean :air_conditioning, default: false
      t.boolean :tv, default: false
      t.boolean :wardrobe, default: false
      t.boolean :safe_available, default: false
      t.boolean :accessible_for_disabled, default: false
      t.integer :for_reservations, default: 0

      t.timestamps
    end
  end
end
