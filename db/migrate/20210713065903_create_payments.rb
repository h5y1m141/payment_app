class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true      
      t.references :payment_method, null: false, foreign_key: true
      t.integer :amount, null: false, comment: '決済時の金額を保持しておく必要あるためにこのカラムを利用'
      t.integer :payment_type, null: false, comment: '取引毎のステータス（注文開始、注文失敗、再決済、注文キャンセル・・等）をENUM型で処理する想定。'
      t.string :code, null: false, comment: '決済プロバイダーからのレスポンス情報を格納する想定', default: '該当なし'

      t.timestamps
    end
  end
end
