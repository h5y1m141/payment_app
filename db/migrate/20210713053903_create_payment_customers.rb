class CreatePaymentCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_customers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :customer_id, null: false

      t.timestamps
    end
  end
end
