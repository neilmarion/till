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

ActiveRecord::Schema[8.0].define(version: 2025_08_13_051905) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "basket_items", force: :cascade do |t|
    t.bigint "basket_id", null: false
    t.bigint "product_id", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_basket_items_on_basket_id"
    t.index ["product_id"], name: "index_basket_items_on_product_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.decimal "total_price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_code", null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "discount_rule"
    t.integer "discount_percentage"
    t.integer "discount_threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_code"], name: "index_products_on_product_code", unique: true
  end

  add_foreign_key "basket_items", "baskets"
  add_foreign_key "basket_items", "products"
end
