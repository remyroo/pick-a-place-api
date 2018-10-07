# frozen_string_literal: true

ActiveRecord::Schema.define(version: 2018_10_07_135447) do
  enable_extension "plpgsql"

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.integer "radius", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
