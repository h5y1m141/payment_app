class AddShippingStateIdToShippings < ActiveRecord::Migration[6.1]
  def change
    add_reference :shippings, :shipping_state, foreign_key: true

    remove_reference :shippings, :order, foreign_key: true
  end
end
