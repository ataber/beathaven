class AddRecipientIdToPerformers < ActiveRecord::Migration
  def change
    add_column :performers, :recipient_id, :string
  end
end
