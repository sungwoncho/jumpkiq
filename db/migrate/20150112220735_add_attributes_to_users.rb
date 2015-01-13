class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :casual_shirt_size, :string
    add_column :users, :long_sleeve, :boolean, default: false
    add_column :users, :short_sleeve, :boolean, default: false
    add_column :users, :polo_shirt, :boolean, default: false
    add_column :users, :pants, :boolean, default: false
    add_column :users, :shorts, :boolean, default: false
    add_column :users, :smart_kiq, :boolean, default: false
    add_column :users, :casual_kiq, :boolean, default: false
    add_column :users, :hipster_kiq, :boolean, default: false
    add_column :users, :classic_kiq, :boolean, default: false
  end
end
