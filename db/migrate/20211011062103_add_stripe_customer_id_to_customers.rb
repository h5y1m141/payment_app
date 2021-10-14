class AddStripeCustomerIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :stripe_customer_id, :string, null: false, default: ''
  end
end
