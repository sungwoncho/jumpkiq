class AddStylistToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stylist, :boolean, default: false
  end
end
