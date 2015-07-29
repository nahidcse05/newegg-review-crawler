require 'json'

cats = `ls reviews/newegg/`.split

all = {}
for cat in cats
  all[cat] = {}
  puts "Parsing category \"#{cat}\"..."
  for file in `ls reviews/newegg/#{cat}`.split
    item = /[^\.]*/.match(file)
    puts "  found item #{item}"
    content = File.open("reviews/newegg/#{cat}/#{file}", 'r').read
    all[cat][item] = JSON.parse(content)
  end
end

output = File.open("newegg-reviews.json", 'w')
output << JSON.pretty_generate(all)
