# Categories both in Amazon and NewEgg
  - camera
  - tablet
  - phone
  - tv
  
# Instruction for Running
 - Make sure you have a list of items in a .csv file under each category in folder Amazon
 - Make sure .csv file in UTF-8 format
 - For converting to UTF-8 format open the .csv file using notepad++(for windows)or notepadqq(for ubuntu), then from encoding tab select convert to UTF-8 then save the file in .csv format.
 - Run first amazon-searcher-camera.rb then amazon-getreviews-camera.rb 
 - similarly run for the other categories from above
 - amazon-searcher-camera.rb takes an argument which is camera
 - amazon-getreviews-camera.rb takes an argument which is camera
 - finally run combine.rb to get all the reviews of all categories in one file named newegg-reviews.json 

# Ruby installation in Ubuntu 14.04LTS
  - sudo apt-get install ruby-all

# Ruby command
 - ruby amazon-searcher-camera.rb camera 
 - ruby amazon-getreviews-camera.rb camera
 
# Categories crawled
  - camera: 2550 items, 1018 reviews
  - phone: 471 items, 1265 reviews
  - tablet: 3267 items, 6853 reviews
  - tv: 637 items, 1559 reviews

# Egg (rating) distribution:
 - 1: 2266 (21.19%)
 - 2: 1060 (9.91%)
 - 3: 1105 (10.33%)
 - 4: 1987 (18.58%)
 - 5: 4277 (39.99%)

6925 total items, 10695 total reviews
