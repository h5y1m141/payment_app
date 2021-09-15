class CreateAdminAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_accounts do |t|
      t.string :uid

      t.timestamps
    end
  end
end
