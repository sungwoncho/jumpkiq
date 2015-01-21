class CreateKiqItems < ActiveRecord::Migration
  def change
    create_table :kiq_items do |t|
      t.references :kiq
      t.references :item

      t.timestamps null: false
    end
  end
end
