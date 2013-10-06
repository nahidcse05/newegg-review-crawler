require 'json'

all = JSON.parse(File.open("newegg-reviews.json", 'r').read)
prefix = "/home/sean/projects/meta-data/newegg"
full_corpus = File.open("#{prefix}/newegg-full-corpus.txt", 'w')

i = 0
for cat, items in all
  for item, revs in items
    for rev in revs

      if rev["Pros"].split.size > 5
        pfilename = "pos/#{cat}-#{item}-pos-#{i}"
        pout = File.open("#{prefix}/#{pfilename}", 'w')
        pout << rev["Pros"] << "\n"
        pout.close()
        full_corpus << "pos #{pfilename}" << "\n"
      end

      if rev["Cons"].split.size > 5
        nfilename = "neg/#{cat}-#{item}-neg-#{i}"
        nout = File.open("#{prefix}/#{nfilename}", 'w')
        nout << rev["Cons"] << "\n"
        full_corpus << "neg #{nfilename}" << "\n"
        nout.close()
      end

      i += 1
    end
  end
end
