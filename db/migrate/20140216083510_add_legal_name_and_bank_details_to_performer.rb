class AddLegalNameAndBankDetailsToPerformer < ActiveRecord::Migration
  def change
    add_column :performers, :legal_billing_name, :string
    add_column :performers, :bank_number, :integer
  end
end
