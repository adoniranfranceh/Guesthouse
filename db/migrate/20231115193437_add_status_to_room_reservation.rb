class AddStatusToRoomReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :room_reservations, :status, :integer, default: 5
  end
end
