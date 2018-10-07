# frozen_string_literal: true

ActiveRecord::Schema.define(version: 2018_10_07_184523) do
  enable_extension "plpgsql"

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.integer "radius", null: false
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
