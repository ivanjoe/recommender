#user id | item id | rating | timestamp
lines = File.readlines('/home/ivanjoe/Projects/automatic_recommender/lib/parser/ratings_data/u_utf8.item')
movies = lines.map do |line|
  line.strip.split(/\|/).map{|s| s.to_s}
end

false_true = [false, true]

movies.each do |row|
  p row
  m = Movie.new
  m.movie_id = row[0].to_i
  m.movie_title = row[1]
  m.release_date = Date.strptime(row[2], "%d-%b-%Y") if row[2].present?
  m.video_release_date = Date.strptime(row[3], "%d-%b-%Y") if row[3].present?
  m.imdb_url = row[4]
  m.action = false_true[row[6].to_i]
  m.adventure = false_true[row[7].to_i]
  m.animation = false_true[row[8].to_i]
  m.children = false_true[row[9].to_i]
  m.comedy = false_true[row[10].to_i]
  m.crime = false_true[row[11].to_i]
  m.documentary = false_true[row[12].to_i]
  m.drama = false_true[row[13].to_i]
  m.fantasy = false_true[row[14].to_i]
  m.film_noir = false_true[row[15].to_i]
  m.horror = false_true[row[16].to_i]
  m.musical = false_true[row[17].to_i]
  m.mystery = false_true[row[18].to_i]
  m.romance = false_true[row[19].to_i]
  m.sci_fi = false_true[row[20].to_i]
  m.thriller = false_true[row[21].to_i]
  m.war = false_true[row[22].to_i]
  m.western = false_true[row[23].to_i]
  m.save!
end
