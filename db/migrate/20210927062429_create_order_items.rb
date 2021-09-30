class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :product_name, null: false
      t.integer :product_unit_price, null: false
      t.integer :quantity, null: false
      t.integer :sub_total, null: false

      t.timestamps
    end
  end
end
