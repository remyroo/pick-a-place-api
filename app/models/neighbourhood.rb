class Neighbourhood < ApplicationRecord
  has_many :venues

  validates_presence_of :name, :latitude, :longitude, :radius
end
