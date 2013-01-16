json=File.read(Rails.root.to_s+"/lib/parser/ratings_data/ratings.json")
all_ratings = JSON.parse(json)

all_ratings.each do |rating|
  r = Rating.new
  r.user_id = rating.user_id
  r.item_id = rating.item_id
  r.rating = rating.rating
  r.rated_at = rating.rated_at
  r.save!
end
#heroku run 'rails runner lib/parser/movie_parser.rb'
