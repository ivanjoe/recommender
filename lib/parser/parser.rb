#user id | item id | rating | timestamp
lines = File.readlines('/home/ivanjoe/Projects/automatic_recommender/lib/parser/u.data')
ratings = lines.map do |line|
  line.strip.split(/\t/).map{|s| s.to_i}
end
ratings.each do |row|
  r = Rating.new
  r.user_id = row[0]
  r.item_id = row[1]
  r.rating = row[2]
  r.rated_at = Time.at(row[3])
  r.save!
end
