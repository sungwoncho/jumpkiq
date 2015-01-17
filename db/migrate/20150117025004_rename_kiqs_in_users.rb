class RenameKiqsInUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :smart_kiq, :smart_style
      t.rename :casual_kiq, :casual_style
      t.rename :hipster_kiq, :hipster_style
      t.rename :classic_kiq, :classic_style
    end
  end
end
