class AddAddrow3ToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :addrow3, :string
  end
end
