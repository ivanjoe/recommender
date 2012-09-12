#user id | item id | rating | timestamp
lines = File.readlines('u.data')
ratings = lines.map do |line|
  line.strip.split(/\t/).map{|s| s.to_i}
end
p ratings.first
