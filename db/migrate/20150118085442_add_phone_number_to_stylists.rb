class AddPhoneNumberToStylists < ActiveRecord::Migration
  def change
    add_column :stylists, :phone_number, :string
  end
end
