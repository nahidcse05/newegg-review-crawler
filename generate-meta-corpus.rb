require 'json'
require 'fileutils'

if ARGV.size == 0
  puts "Usage: ruby generate-meta-corpus.rb prefix"
  exit 1
end

all = JSON.parse(File.open("newegg-reviews.json", 'r').read)
prefix = ARGV[0]
senti_corpus = File.open("#{prefix}/senti-full-corpus.txt", 'w')
category_corpus = File.open("#{prefix}/category-full-corpus.txt", 'w')

def get_file(filename)
  dir = File.dirname(filename)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  return File.open(filename, 'w')
end

i = 0
for cat, items in all
  for item, revs in items
    for rev in revs

      if rev["Pros"].split.size > 5
        pfilename = "pos/#{cat}-#{item}-pos-#{i}"
        pout = get_file("#{prefix}/#{pfilename}")
        pout << rev["Pros"] << "\n"
        pout.close()
        senti_corpus << "pos #{pfilename}" << "\n"
      end

      if rev["Cons"].split.size > 5
        nfilename = "neg/#{cat}-#{item}-neg-#{i}"
        nout = get_file("#{prefix}/#{nfilename}")
        nout << rev["Cons"] << "\n"
        senti_corpus << "neg #{nfilename}" << "\n"
        nout.close()
      end

      if rev["Pros"].split.size +
         rev['Cons'].split.size +
         rev['Comments'].split.size > 10
        filename = "#{cat}/#{item}-#{i}"
        out = get_file("#{prefix}/#{filename}")
        out << rev['Pros'] << "\n\n" << rev['Cons'] << "\n\n" << rev['Comments'] << "\n"
        category_corpus << "#{cat} #{filename}" << "\n"
        out.close()
      end

      i += 1
    end
  end
end
