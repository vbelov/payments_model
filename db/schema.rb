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

ActiveRecord::Schema.define(version: 20170807105838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  create_table "segments", force: :cascade do |t|
    t.integer "region_ids", default: [], array: true
    t.integer "payments"
    t.string "b2what"
    t.integer "levels", default: [], array: true
    t.integer "trials_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer "region_id"
    t.integer "level"
    t.string "b2what"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
