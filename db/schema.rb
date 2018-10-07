# frozen_string_literal: true
ActiveRecord::Schema.define(version: 2018_10_07_135732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.integer "radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
