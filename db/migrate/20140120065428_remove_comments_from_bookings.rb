class RemoveCommentsFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :comments
  end
end
