class ChangeOrderColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :payment_intent_id, :string, null: false, default: '', after: :user_id
    add_column :orders, :total_price, :integer, null: false, default: 0, after: :payment_intent_id

    remove_column :orders, :product_id, :integer
    remove_column :orders, :quantity, :integer
    remove_column :orders, :amount, :integer
  end
end
