class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.string :opening_hours, null: false
      t.string :website_url, null: false
      t.string :photo
      t.float :rating
      t.integer :venue_category
      t.integer :price_range
      t.references :neighbourhood, index: true, foreign_key: true

      t.timestamps
    end
  end
end
