class CreateOrder < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.text :name
      t.text :phone
      t.text :address
      t.text :order_data

      t.timestamps
    end
  end
end
