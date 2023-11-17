class AddColumnsToRoomReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :room_reservations, :chosen_payment_method, :string
    add_column :room_reservations, :guest_departure, :datetime
  end
end
