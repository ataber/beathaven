class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.timestamps
      t.references :user
      t.references :performer
      t.text :content
    end
  end
end
