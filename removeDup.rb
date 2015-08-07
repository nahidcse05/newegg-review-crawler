require 'json'

def percent(count, total)
  "#{(count.to_f / total * 100).round(2)}%"
end

all = JSON.parse(File.open("newegg.json", 'r').read)
allc = JSON.parse(File.open("newegg-reviews.json", 'r').read)
item_count = 0
total_reviews = 0
eggs = [0, 0, 0, 0, 0]

seen = {}
unique = {}
cats = `ls reviews/newegg/`.split
for cat in cats
  unique[cat] = {}
end

puts ""
for cat, items in all
  item_count += items.size
  reviews = 0
  for item, revs in items
    norev = []
    reviews += revs.size
    for rev in revs
      eggs[rev["Rating"] - 1] += 1
      key = rev["Title"] + rev["PublishDate"]
      if not seen.has_key? key
        seen[key] = true
        norev << rev
      end
    end
    unique[cat][item] = norev
  end
  puts "#{cat}: #{items.size} items, #{reviews} reviews"
  total_reviews += reviews
end

for cat, items in allc
  item_count += items.size
  reviews = 0
  for item, revs in items
    norev = []
    reviews += revs.size
    for rev in revs
      eggs[rev["Rating"] - 1] += 1
      key = rev["Title"] + rev["PublishDate"]
      if not seen.has_key? key
        seen[key] = true
        norev << rev
      end
    end
    unique[cat][item] = norev
  end
  puts "#{cat}: #{items.size} items, #{reviews} reviews"
  total_reviews += reviews
end


temp = File.open("combined_without_duplicates.json", 'w')
temp << JSON.pretty_generate(unique)
temp.close()
 
puts "\nEgg (rating) distribution:"
eggs.each_with_index { |egg, i|
  puts " #{i + 1}: #{egg} (#{percent(egg, total_reviews)})"
}

puts "\n#{item_count} total items, #{total_reviews} total reviews"
