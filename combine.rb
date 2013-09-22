require 'json'

cats = ["hdd", "video-card", "monitor", "motherboard"]

all = {}
for cat in cats
  all[cat] = {}
  puts "Parsing category \"#{cat}\"..."
  for file in `ls reviews/#{cat}`.split
    item = /[^\.]*/.match(file)
    puts "  found item #{item}"
    content = File.open("reviews/#{cat}/#{file}", 'r').read
    all[cat][item] = JSON.parse(content)
  end
end

output = File.open("newegg-reviews.json", 'w')
output << JSON.pretty_generate(all)
