class CreateOrders < ActiveRecord::Migration
  def change
    create_table :order do |t|
      t.integer :number
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
