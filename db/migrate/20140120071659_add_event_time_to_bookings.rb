class AddEventTimeToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :event_time, :time
  end
end
