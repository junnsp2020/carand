# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_07_082748) do

  create_table "administers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administers_on_reset_password_token", unique: true
  end

  create_table "barter_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "product_id"
    t.string "name"
    t.string "image_id"
    t.text "introduction"
    t.integer "product_condition", default: 0
    t.text "comment"
    t.boolean "propriety"
    t.integer "seller_id"
    t.integer "buyer_id"
    t.boolean "notice"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
    t.string "name"
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "product_id"
  end

  create_table "product_comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "product_id"
    t.text "comment"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "user_id"
    t.string "name"
    t.string "image_id"
    t.text "introduction"
    t.integer "price"
    t.integer "profit"
    t.integer "postage"
    t.integer "postage_responsibility", default: 0
    t.integer "status", default: 0
    t.integer "sale_status", default: 0
    t.integer "propriety", default: 0
    t.boolean "notice"
    t.boolean "barter_approval"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.integer "subject"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "product_id"
  end

  create_table "trading_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "trading_id"
    t.text "message"
    t.integer "user_id"
    t.boolean "buyer_notice"
  end

  create_table "tradings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "product_id"
    t.integer "status", default: 0
    t.integer "paymethod"
    t.integer "buyer_id"
    t.integer "seller_id"
    t.integer "shipment_status", default: 0
    t.integer "payment_status", default: 0
    t.boolean "excellent_review"
    t.boolean "good_review"
    t.boolean "poor_review"
    t.boolean "seller_excellent_review"
    t.boolean "seller_good_review"
    t.boolean "seller_poor_review"
    t.boolean "buyer_notice"
    t.boolean "seller_notice"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "last_name_kana"
    t.string "first_name_kana"
    t.string "image_id"
    t.text "introduction"
    t.integer "postcode"
    t.string "address_city"
    t.string "address_street"
    t.string "phone_number"
    t.boolean "is_deleted"
    t.string "bank_name"
    t.string "account_type"
    t.string "branch_code"
    t.string "account_number"
    t.string "account_last_name_kana"
    t.string "account_first_name_kana"
    t.integer "balance"
    t.string "address_building"
    t.integer "buyer_id"
    t.integer "seller_id"
    t.integer "request_amount"
    t.integer "commission"
    t.string "nickname"
    t.string "prefecture_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "product_id"
  end

end
