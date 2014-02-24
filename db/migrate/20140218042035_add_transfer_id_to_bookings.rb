class AddTransferIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :transfer_id, :string
  end
end
