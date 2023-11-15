class CreateRoomReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :room_reservations do |t|
      t.date :check_in
      t.date :check_out
      t.string :quantity
      t.integer :number_of_guests
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
