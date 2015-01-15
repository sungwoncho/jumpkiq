class RenameColumnsInAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :address, :street_address
    rename_column :addresses, :address_2, :secondary_address
  end
end
