# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_11_061001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "admin_accounts", force: :cascade do |t|
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customer_payment_methods", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "payment_method_id", null: false
    t.integer "exp_month", null: false
    t.integer "exp_year", null: false
    t.string "brand", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_customer_payment_methods_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "destinations", force: :cascade do |t|
    t.string "zipcode", null: false
    t.string "address", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_destinations_on_order_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "product_name", null: false
    t.integer "product_unit_price", null: false
    t.integer "quantity", null: false
    t.integer "sub_total", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "payment_intent_id", default: "", null: false
    t.integer "total_price", default: 0, null: false
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "payment_customers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_payment_customers_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "payment_method_id", null: false
    t.integer "amount", null: false, comment: "決済時の金額を保持しておく必要あるためにこのカラムを利用"
    t.integer "payment_type", null: false, comment: "取引毎のステータス（注文開始、注文失敗、再決済、注文キャンセル・・等）をENUM型で処理する想定。"
    t.string "code", default: "該当なし", null: false, comment: "決済プロバイダーからのレスポンス情報を格納する想定"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "product_stocks", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "stock", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_stocks_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "customer_payment_methods", "customers"
  add_foreign_key "destinations", "orders"
  add_foreign_key "order_items", "orders"
  add_foreign_key "payment_customers", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "payments", "payment_methods"
  add_foreign_key "product_stocks", "products"
  add_foreign_key "user_profiles", "users"
end
