class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|
      t.string :zipcode, null: false
      t.string :address, null: false
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
