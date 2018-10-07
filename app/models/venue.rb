class Venue < ApplicationRecord
  validates_presence_of :name, :address, :opening_hours, :website_url
end
