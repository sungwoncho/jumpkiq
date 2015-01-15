class RemoveStylistFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :stylist, :boolean
  end
end
