class ChangeUserColumnAtOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :user
    add_reference :orders, :customer
  end
end
