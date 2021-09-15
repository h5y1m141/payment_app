class CreateUserCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :user_credit_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :card_id, null: false
      t.integer :exp_month, null: false
      t.integer :exp_year, null: false
      t.string :brand, null: false

      t.timestamps
    end
  end
end
