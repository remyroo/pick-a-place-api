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

ActiveRecord::Schema.define(version: 2018_11_30_134926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.integer "radius", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name", null: false
    t.text "address", null: false
    t.string "opening_hours", null: false
    t.string "website_url", null: false
    t.string "photo"
    t.float "rating"
    t.integer "venue_category"
    t.integer "price_range"
    t.bigint "neighbourhood_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["neighbourhood_id"], name: "index_venues_on_neighbourhood_id"
  end

  add_foreign_key "venues", "neighbourhoods"
end
