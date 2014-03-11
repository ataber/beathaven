class AddLocationToPerformers < ActiveRecord::Migration
  def change
    add_column :performers, :location, :string
  end
end
