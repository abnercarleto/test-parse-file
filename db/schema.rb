# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_15_025141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.bigint "sale_id", null: false
    t.bigint "product_id", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.integer "count", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["sale_id", "product_id"], name: "index_items_on_sale_id_and_product_id", unique: true
    t.index ["sale_id"], name: "index_items_on_sale_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "address"], name: "index_merchants_on_name_and_address", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "description", null: false
    t.bigint "merchant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_id", "description"], name: "index_products_on_merchant_id_and_description", unique: true
    t.index ["merchant_id"], name: "index_products_on_merchant_id"
  end

  create_table "purchasers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_purchasers_on_name", unique: true
  end

  create_table "sale_imports", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "purchaser_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sale_import_id"
    t.index ["purchaser_id"], name: "index_sales_on_purchaser_id"
    t.index ["sale_import_id"], name: "index_sales_on_sale_import_id"
  end

  add_foreign_key "items", "products"
  add_foreign_key "items", "sales"
  add_foreign_key "products", "merchants"
  add_foreign_key "sales", "purchasers"
  add_foreign_key "sales", "sale_imports"
end
