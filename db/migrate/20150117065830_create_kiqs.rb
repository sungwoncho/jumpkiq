class CreateKiqs < ActiveRecord::Migration
  def change
    create_table :kiqs do |t|
      t.references :user
      t.references :stylist
      t.string :status, default: 'requested'
      t.timestamps null: false
    end
  end
end
