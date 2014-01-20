class ChangeBookingEventDateToDate < ActiveRecord::Migration
  def change
    change_column :bookings, :event_date, :date
  end
end
