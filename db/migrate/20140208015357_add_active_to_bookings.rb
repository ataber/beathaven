class AddActiveToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :active, :boolean, default: true
  end
end
