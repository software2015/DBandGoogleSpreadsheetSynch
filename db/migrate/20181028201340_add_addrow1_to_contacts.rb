class AddAddrow1ToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :addrow1, :string
  end
end
