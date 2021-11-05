class AddShippingAddressColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :shipping_address, foreign_key: true
  end
end
