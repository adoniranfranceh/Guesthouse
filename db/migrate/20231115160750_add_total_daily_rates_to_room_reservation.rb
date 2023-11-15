class AddTotalDailyRatesToRoomReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :room_reservations, :total_daily_rates, :integer
  end
end
