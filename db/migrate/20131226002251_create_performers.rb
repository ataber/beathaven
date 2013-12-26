class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.string :name
      t.references :user
      t.string :genre
      t.timestamps
    end
  end
end
