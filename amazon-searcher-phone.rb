require 'csv'
require 'json'
require 'uri'
require 'net/http'

uri = URI.parse("http://www.ows.newegg.com")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new("/Search.egg/Advanced")
request.add_field('Content-Type', 'application/x-www-form-urlencoded')
request.add_field('User-Agent', 'Newegg iPhone App / 4.1.2')

data = {
    "PageNumber" => 1,
    "BrandId" => -1,
    "NValue" => "",
    "StoreDepaId" => -1,
    "NodeId" => -1,
    "Keyword" => "",
    "IsSubCategorySearch" => false,
    "SubCategoryId" => -1,
    "Sort" => "REVIEWS",
    "CategoryId" => -1,
    "IsUPCCodeSearch" => false
}

idx = 0
out = File.open("phone-output.txt", 'w')
File.open("amazon/Amazon_phone.csv").each do |line|
  idx += 1
  puts idx
  line.chomp!
  line.encode!("utf-8", "utf-8", :invalid => :replace)
  fields = CSV.parse_line(line)
  data["Keyword"] = "\"#{fields[2]}\""
  request.body = data.to_json
  response = nil
  begin
    response = http.request(request)
  rescue
    puts " -> error!"
    next
  end
  body = JSON.parse(response.body)
  if body["CoremetricsInfo"]["PageID"] == "search results: unsuccessful"
    puts " -> no search results!"
    next
  end
  for item in body["ProductListItems"]
    reviews = /[0-9,]+/.match item["ReviewSummary"]["TotalReviews"]
    puts " -> #{item["NeweggItemNumber"]}"
    out << "#{item["NeweggItemNumber"]}\t#{fields[0]}\t#{reviews}\t#{item["Title"]}\n"
    break
  end
  `sleep 1`
end
