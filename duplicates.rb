# remove duplicate entries from an array of JSON objects

require 'json'

def main(cat)
  for file in File.open("#{cat}-search-results.txt", 'r')
    tokens = file.split
    file = tokens[0]
    json = JSON.parse(File.open("reviews/#{cat}/#{file}.json", 'r').read)
  
    seen = {}
    unique = []

    for rev in json
      key = rev["Title"] + rev["PublishDate"]
      if not seen.has_key? key
        seen[key] = true
        unique << rev
      end
    end

    temp = File.open("temp", 'w')
    temp << JSON.pretty_generate(unique)
    temp.close()
    `mv temp reviews/#{cat}/#{file}.json`
  end
end

if ARGV.empty?
  puts "usage: ruby duplicates.rb category"
else
  main(ARGV[0])
end
