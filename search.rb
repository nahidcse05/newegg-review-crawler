# search for a string and get the top 20 pages of search results sorted by
# number of reviews

require 'json'
require 'uri'
require 'net/http'

search_string = "monitor"

uri = URI.parse("http://www.ows.newegg.com")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new("/Search.egg/Advanced")
request.add_field('Content-Type', 'application/x-www-form-urlencoded')

data = {
    "PageNumber" => 1,
    "BrandId" => -1,
    "NValue" => "",
    "StoreDepaId" => -1,
    "NodeId" => -1,
    "Keyword" => search_string,
    "IsSubCategorySearch" => false,
    "SubCategoryId" => -1,
    "Sort" => "REVIEWS",
    "CategoryId" => -1,
    "IsUPCCodeSearch" => false
}

puts "Starting to crawl..."

for page in 1..20
  data["PageNumber"] = page
  request.body = data.to_json
  response = http.request(request)
  body = JSON.parse(response.body)
  for item in body["ProductListItems"]
    reviews = /[0-9,]+/.match item["ReviewSummary"]["TotalReviews"]
    puts "#{item["NeweggItemNumber"]} #{reviews} (#{item["Title"]})"
  end
end
