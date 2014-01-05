class AddCommentsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :comments, :text
  end
end
