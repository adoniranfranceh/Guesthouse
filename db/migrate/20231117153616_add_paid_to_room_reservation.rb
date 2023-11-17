class AddPaidToRoomReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :room_reservations, :paid, :integer
  end
end
