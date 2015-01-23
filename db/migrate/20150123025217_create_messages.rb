class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.references :stylist
      t.text :body
      t.boolean :is_read, default: false

      t.timestamps null: false
    end
  end
end
