# Categories both in Amazon and NewEgg
  - camera
  - tablet
  - phone
  - tv
  
# Instruction for Running
 - Make sure you have a list of items in a .csv file under each category in folder Amazonfile 
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

 - hdd: 97 items, 22416 reviews
 - monitor: 107 items, 12890 reviews
 - motherboard: 249 items, 23419 reviews
 - power-supply: 204 items, 33399 reviews
 - router: 191 items, 26978 reviews
 - video-card: 282 items, 17819 reviews

# Egg (rating) distribution:
 - 1: 19,514 (14.25%)
 - 2: 8,547 (6.24%)
 - 3: 8,912 (6.51%)
 - 4: 20,401 (14.9%)
 - 5: 79,547 (58.1%)

1,130 total items, 136,921 total reviews
