# from a list of item ids (item-ids.txt), collect all reviews for each product

require 'json'
require 'open-uri'

def get_review_page(item, page)
  base_url = "http://www.ows.newegg.com/Products.egg"
  content = open("#{base_url}/#{item}/reviews/#{page}").read
  JSON.parse(content)
end

def main(cat)
  num_reviews = 0
  for line in File.open("#{cat}-search-results.txt", 'r').readlines
    tokens = line.split
    item = tokens[0]
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
    output.close()

    num_reviews += reviews.size
    puts "  -> found #{reviews.size} reviews"
  end

  puts "Found #{num_reviews} total reviews"
end

if ARGV.empty?
  puts "usage: ruby duplicates.rb category"
else
  main(ARGV[0])
end
