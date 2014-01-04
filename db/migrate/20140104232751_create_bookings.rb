class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.timestamps
      t.datetime :event_date
      t.references :performer
      t.decimal :cost, :precision => 8, :scale => 2
    end
  end
end
