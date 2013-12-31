class AddDescriptionToPerformers < ActiveRecord::Migration
  def change
    add_column :performers, :description, :text
  end
end
