# from a list of item ids (item-ids.txt), collect all reviews for each product

require 'json'
require 'open-uri'
require 'uri'
require 'net/http'

def get_review_page(item, page)
  `sleep 0.5`
  uri = URI.parse("http://www.ows.newegg.com")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new("/Products.egg/#{item}/Reviews")
  request.add_field('Content-Type', 'application/x-www-form-urlencoded')
  request.add_field('User-Agent', 'Newegg iPhone App / 4.1.2')
  params = {"PageNumber" => page}
  request.body = params.to_json
  response = http.request(request)
  JSON.parse(response.body)
end

def main(cat)
  num_reviews = 0
  for line in File.open("#{cat}-output.txt", 'r').readlines
    tokens = line.split
    item = tokens[0]
    amazon_item = tokens[1]
    reviews = []
    i = 0
    puts "Crawling reviews for item #{item}..."
    while true
      json_content = get_review_page(item, i)
      p_info = json_content["PaginationInfo"]
      break if reviews.size >= p_info["TotalCount"]
      puts "  -> crawled page #{i}"
      reviews += json_content["Reviews"]
      i += 1
    end
    output = File.open("reviews/#{cat}/#{item}.json", 'w')
    output << JSON.pretty_generate(reviews)
    output.close
    num_reviews += reviews.size
    puts "  -> found #{reviews.size} reviews"
  end
  puts "Found #{num_reviews} total reviews"
end

if ARGV.empty?
  puts "usage: ruby get-reviews.rb category"
else
  main(ARGV[0])
end
