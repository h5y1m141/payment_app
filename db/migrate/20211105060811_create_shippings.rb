class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :status, null: false

      t.timestamps
    end
  end
end
