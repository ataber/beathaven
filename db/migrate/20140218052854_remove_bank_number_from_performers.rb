class RemoveBankNumberFromPerformers < ActiveRecord::Migration
  def change
    remove_column :performers, :bank_number
    remove_column :performers, :legal_billing_name
  end
end
