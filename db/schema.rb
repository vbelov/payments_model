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

ActiveRecord::Schema.define(version: 20170909112927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ab_tests", force: :cascade do |t|
    t.string "type"
    t.integer "segment_id"
    t.integer "groups_count"
    t.json "participants", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bundles", force: :cascade do |t|
    t.string "name"
    t.json "items_json", default: {}
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer "bundle_id", null: false
    t.integer "segment_id"
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_ab_test_id"
    t.string "ab_group"
    t.index ["payment_ab_test_id"], name: "index_offers_on_payment_ab_test_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "offer_id", null: false
    t.integer "student_id", null: false
    t.integer "price", null: false
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "order_id"
    t.integer "amount"
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "segments", force: :cascade do |t|
    t.string "type"
    t.json "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer "region_id"
    t.integer "level"
    t.string "b2what"
    t.json "subscriptions_json", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "ab_groups", default: {}
  end

end
