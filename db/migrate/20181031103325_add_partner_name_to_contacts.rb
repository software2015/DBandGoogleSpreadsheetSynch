class AddPartnerNameToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :partner_name, :string
  end
end
