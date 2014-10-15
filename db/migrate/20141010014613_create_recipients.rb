class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :stripe_id, null: false
    end
  end
end
