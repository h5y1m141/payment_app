class DropUserCreditCards < ActiveRecord::Migration[6.1]
  def change
    drop_table :user_credit_cards do |t|
      t.bigint "user_id", null: false
      t.string "card_id", null: false
      t.integer "exp_month", null: false
      t.integer "exp_year", null: false
      t.string "brand", null: false

      t.timestamps null: false
    end
  end
end
