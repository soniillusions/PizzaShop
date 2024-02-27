class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.text :order_input
      t.text :name
      t.text :phone
      t.text :address

      t.timestamps
    end
  end
end
