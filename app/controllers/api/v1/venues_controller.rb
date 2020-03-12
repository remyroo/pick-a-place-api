module Api
  module V1
    class VenuesController < ApplicationController
      def search
        # venue_search = VenuesSearch.new('1.2807,36.7817')
        venue_search = VenuesSearch.new('-33.8670522,151.1957362') # returns 2 results at radius 50
        result = venue_search.get_nearby_venues
        json_response(result, :ok)
      end
    end
  end
end
