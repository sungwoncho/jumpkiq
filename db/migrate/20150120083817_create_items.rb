class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.string :kind
      t.string :status, default: 'available'
      t.integer :value
      t.integer :purchased_value
      t.boolean :smart, default: false
      t.boolean :casual, default: false
      t.boolean :hipster, default: false
      t.boolean :classic, default: false

      t.timestamps null: false
    end
  end
end
