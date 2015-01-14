class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :user
      t.references :stylist

      t.timestamps null: false
    end
  end
end
