class AddSoftDeleteToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :hidden, :boolean, default: false, null: false
  end
end
