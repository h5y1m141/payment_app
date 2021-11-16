class CreateShippingStates < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_states do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :aasm_state, null: false

      t.timestamps
    end
  end
end
