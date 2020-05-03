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

ActiveRecord::Schema.define(version: 2020_05_02_190620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "link_customs", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.string "short_path", null: false
    t.integer "click_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_link_customs_on_link_id"
    t.index ["short_path"], name: "index_link_customs_on_short_path", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.text "original_url", null: false
    t.string "short_path", null: false
    t.integer "click_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["original_url"], name: "index_links_on_original_url", unique: true
    t.index ["short_path"], name: "index_links_on_short_path", unique: true
  end

end
