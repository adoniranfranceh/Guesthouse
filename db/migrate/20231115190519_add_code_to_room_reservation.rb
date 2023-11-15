class AddCodeToRoomReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :room_reservations, :code, :string
  end
end
