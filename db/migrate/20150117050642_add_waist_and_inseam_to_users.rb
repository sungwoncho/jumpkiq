class AddWaistAndInseamToUsers < ActiveRecord::Migration
  def change
    add_column :users, :waist, :integer
    add_column :users, :inseam, :integer
  end
end
