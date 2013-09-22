require 'json'

all = JSON.parse(File.open("newegg-reviews.json", 'r').read)
item_count = 0
total_reviews = 0

for cat, items in all
  item_count += items.size
  reviews = 0
  for item, revs in items
    reviews += revs.size
  end
  puts "#{cat}: #{items.size} items, #{reviews} reviews"
  total_reviews += reviews
end

puts "#{item_count} total items, #{total_reviews} total reviews"
