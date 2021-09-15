class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
