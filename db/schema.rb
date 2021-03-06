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

ActiveRecord::Schema.define(version: 2021_11_17_051005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "stripe_customer_id", default: "", null: false
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
    t.bigint "shipping_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
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
    t.integer "amount", null: false, comment: "????????????????????????????????????????????????????????????????????????????????????"
    t.integer "payment_type", null: false, comment: "????????????????????????????????????????????????????????????????????????????????????????????????????????????ENUM???????????????????????????"
    t.string "code", default: "????????????", null: false, comment: "???????????????????????????????????????????????????????????????????????????"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "shipping_addresses", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "zipcode", null: false
    t.bigint "prefecture_id", null: false
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_shipping_addresses_on_customer_id"
    t.index ["prefecture_id"], name: "index_shipping_addresses_on_prefecture_id"
  end

  create_table "shipping_states", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "aasm_state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_shipping_states_on_order_id"
  end

  create_table "shippings", force: :cascade do |t|
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shipping_state_id"
    t.index ["shipping_state_id"], name: "index_shippings_on_shipping_state_id"
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
  add_foreign_key "orders", "shipping_addresses"
  add_foreign_key "payment_customers", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "payments", "payment_methods"
  add_foreign_key "product_stocks", "products"
  add_foreign_key "shipping_addresses", "customers"
  add_foreign_key "shipping_addresses", "prefectures"
  add_foreign_key "shipping_states", "orders"
  add_foreign_key "shippings", "shipping_states"
  add_foreign_key "user_profiles", "users"
end
