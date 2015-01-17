class AddBudgetsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :long_sleeve_max_budget, :integer, default: 0
    add_column :users, :short_sleeve_max_budget, :integer, default: 0
    add_column :users, :polo_shirt_max_budget, :integer, default: 0
    add_column :users, :pants_max_budget, :integer, default: 0
    add_column :users, :shorts_max_budget, :integer, default: 0
  end
end
