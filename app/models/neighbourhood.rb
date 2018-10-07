class Neighbourhood < ApplicationRecord
  validates_presence_of :name, :latitude, :longitude, :radius
end
