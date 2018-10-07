class Venue < ApplicationRecord
  belongs_to :neighbourhood

  validates_presence_of :name, :address, :opening_hours, :website_url
end
