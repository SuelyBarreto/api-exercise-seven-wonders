require 'httparty'
require 'dotenv'
require 'awesome_print'

BASE_URL = "https://us1.locationiq.com/v1/search.php"
LOCATION_IQ_KEY = ENV['LOCATION_IQ_KEY']

def get_location(search_term)
  Dotenv.load
  
  unless ENV['LOCATION_IQ_KEY']
    puts "Could not load API key, please store in the environment variable 'LOCATION_IQ_KEY'"
    exit
  end

  query = {
    key: LOCATION_IQ_KEY,
    q: search_term,
    format: "json",
  }

  response = HTTParty.get(BASE_URL, query: query)
  
  if response.first.any?
    lat_lon = {lat: response.first["lat"], lon: response.first["lon"]}
    return {search_term => lat_lon}
  else
    return "We couldn't find that place :("
  end

end

def find_seven_wonders
  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end

  return seven_wonders_locations
end

puts "#{find_seven_wonders}"

# unless response.code == 200
#   raise SearchError, "Cannot find #{search_term}"
# end

# return {
#          search_term => {
#            lat: response.first["lat"],
#            lon: response.first["lon"],
#          },
#        }
# end

# Expecting something like:
# [{"Great Pyramid of Giza"=>{:lat=>"29.9791264", :lon=>"31.1342383751015"}}, {"Gardens of Babylon"=>{:lat=>"50.8241215", :lon=>"-0.1506162"}}, {"Colossus of Rhodes"=>{:lat=>"36.3397076", :lon=>"28.2003164"}}, {"Pharos of Alexandria"=>{:lat=>"30.94795585", :lon=>"29.5235626430011"}}, {"Statue of Zeus at Olympia"=>{:lat=>"37.6379088", :lon=>"21.6300063"}}, {"Temple of Artemis"=>{:lat=>"32.2818952", :lon=>"35.8908989553238"}}, {"Mausoleum at Halicarnassus"=>{:lat=>"37.03788265", :lon=>"27.4241455276707"}}]

# What are the constant variables in this file? What are their values? BASE_URL = "THE BASE URL FOR THE API REQUEST", LOCATION_IQ_KEY = "YOUR API TOKEN"
# What are the two methods defined? get_location(search_term), find_seven_wonders
# What is the find_seven_wonders method returning? seven_wonders_locations
# What is API rate limiting? When the site limits the number of requests you can send per given time
# What does Ruby's built-in method sleep do? I waits for some time, like a pause
# Inside of the find_seven_wonders method, what happens inside of the each loop? It waits half a second and gets a location