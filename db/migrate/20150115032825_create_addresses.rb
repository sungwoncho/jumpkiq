class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.integer :postcode

      t.references :user

      t.timestamps null: false
    end
  end
end
