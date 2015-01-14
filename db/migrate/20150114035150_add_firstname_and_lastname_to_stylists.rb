class AddFirstnameAndLastnameToStylists < ActiveRecord::Migration
  def change
    add_column :stylists, :firstname, :string
    add_column :stylists, :lastname, :string
  end
end
