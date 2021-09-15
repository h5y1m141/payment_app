class CreateProductStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :product_stocks do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
  end
end
