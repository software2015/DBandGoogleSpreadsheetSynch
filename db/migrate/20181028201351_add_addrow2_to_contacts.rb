class AddAddrow2ToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :addrow2, :string
  end
end
