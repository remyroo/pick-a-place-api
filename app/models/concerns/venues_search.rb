class VenuesSearch
  BASE_URL = 'https://maps.googleapis.com/maps/api/place/'
  NEARBY_SEARCH = 'nearbysearch/json?'
  TEST_DATA = {"html_attributions" => [],
               "results" =>
     [{"geometry" =>
        {"location" => {"lat" => -33.8669667, "lng" => 151.1958862},
         "viewport" => {"northeast" => {"lat" => -33.8656646697085, "lng" => 151.1970863302915}, "southwest" => {"lat" => -33.8683626302915, "lng" => 151.1943883697085}}},
       "icon" => "https://maps.gstatic.com/mapfiles/place_api/icons/cafe-71.png",
       "id" => "7eaf747a3f6dc078868cd65efc8d3bc62fff77d7",
       "name" => "Biaggio Cafe",
       "opening_hours" => {"open_now" => true},
       "photos" =>
        [{"height" => 667,
          "html_attributions" => ["<a href=\"https://maps.google.com/maps/contrib/102092174792064333884\">Biaggio Cafe</a>"],
          "photo_reference" =>
           "CmRYAAAAWqtXUuSMmf3qIU62ewGnYqgklHnBDDLZokj5rCp0OPcAOy5W_ldlSMiEe_ezhz23D9oCleR-qLxf29_WEwHm19TNmIMsGJ_7GamWLDAS37FfQz4IFoL5P9mZQvicg1NcEhD2QR0uxvmzqO7-_uYsJ9O6GhRukMFqKTvkg0Qr4TY_D9UpzhDD2g",
          "width" => 1000}],
       "place_id" => "ChIJIfBAsjeuEmsRdgu9Pl1Ps48",
       "plus_code" => {"compound_code" => "45MW+69 Pyrmont, New South Wales, Australia", "global_code" => "4RRH45MW+69"},
       "price_level" => 1,
       "rating" => 3.6,
       "reference" => "ChIJIfBAsjeuEmsRdgu9Pl1Ps48",
       "scope" => "GOOGLE",
       "types" => %w[cafe restaurant food point_of_interest store establishment],
       "user_ratings_total" => 53,
       "vicinity" => "48 Pirrama Road, Pyrmont"},
      {"geometry" =>
        {"location" => {"lat" => -33.8671288, "lng" => 151.195339},
         "viewport" =>
          {"northeast" => {"lat" => -33.86574116970849, "lng" => 151.1968106302915}, "southwest" => {"lat" => -33.86843913029149, "lng" => 151.1941126697085}}},
       "icon" => "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png",
       "id" => "8bdf85385635caa3b9df55ec23d533ceb0f2b8c6",
       "name" => "The Century",
       "opening_hours" => {"open_now" => false},
       "photos" =>
        [{"height" => 1989,
          "html_attributions" => ["<a href=\"https://maps.google.com/maps/contrib/105596170874069544981\">The Century</a>"],
          "photo_reference" =>
           "CmRaAAAAYMg_bEDvW_hm4M37BxZiPLVabVnZZWHuVFyeYIg9qC3ffXfaRSwxeQeQX7xDZE6mo2HWJB1cg9-5EaqY6tQL8EgseJVMdhddzCmtQvgbiTQNxZE07PTBkyD0_gm92y_XEhBBjQCrWYFbE8H7NMy9EcpMGhQhwXWZimz6WGnv7XbnjDffwwAXEg",
          "width" => 2048}],
       "place_id" => "ChIJ1-v38TauEmsRNrXszdcSywQ",
       "plus_code" => {"compound_code" => "45MW+44 Pyrmont, New South Wales, Australia", "global_code" => "4RRH45MW+44"},
       "price_level" => 3,
       "rating" => 3.9,
       "reference" => "ChIJ1-v38TauEmsRNrXszdcSywQ",
       "scope" => "GOOGLE",
       "types" => %w[bar restaurant food point_of_interest establishment],
       "user_ratings_total" => 268,
       "vicinity" => "The Star, 80 Pyrmont Street, Pyrmont"}],
               "status" => "OK"}

  def initialize(coordinates)
    @coordinates = coordinates
    @radius = 50 # increase to 1000 eventually
  end

  def nearby_search_params
    NEARBY_SEARCH + {
      location: @coordinates,
      radius: @radius,
      type: 'restaurant',
      key: Rails.application.credentials.google_places_api
    }.to_query
  end

  def place_details_params
    # Single responspiibility, this should probably move.
  end

  def get_nearby_venues
    data = get_venues_raw(nearby_search_params)
    if data["error_message"]
      ["Sorry an error occured: #{data["error_message"]} Please try again later"]
    elsif data["status"] == 'ZERO_RESULTS'
      ['Sorry, we cannot find restaurants near you']
    else
      prettify_raw_data(data["results"])
    end
  end

  def get_venues_raw(search_params, tries=0)
    return TEST_DATA

    return if tries == 2

    response = connect.get(search_params)
    data = JSON.parse(response.body)
    if data["results"].empty? && !data.key?("error_message")
      # widen the radius and search again.
      tries += 1
      new_radius = @radius * 2
      new_params = search_params.gsub("radius=#{@radius}", "radius=#{new_radius}")
      get_venues_raw(new_params, tries)
    end
    data
  end

  def prettify_raw_data(raw_data)
    venue_list = []
    required_venue_components = %w[
      name
      opening_hours
      rating
      user_ratings_total
      vicinity
      photos
      types
      place_id]
    raw_data.each do |data|
      venue_components = {}
      data.each do |key, value|
        venue_components[key] = value if required_venue_components.include?(key)
      end
      venue_list << venue_components
    end
    venue_list
  end

  private
  def connect
    Faraday.new(url: BASE_URL) do |f|
      f.response :logger
    end
  end
end
