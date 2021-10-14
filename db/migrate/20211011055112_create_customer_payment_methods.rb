class CreateCustomerPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_payment_methods do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :payment_method_id, null: false
      t.integer :exp_month, null: false
      t.integer :exp_year, null: false
      t.string :brand, null: false

      t.timestamps
    end
  end
end
