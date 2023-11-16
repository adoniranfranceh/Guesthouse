class AddGuestArrivalToRoomReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :room_reservations, :guest_arrival, :datetime
  end
end
