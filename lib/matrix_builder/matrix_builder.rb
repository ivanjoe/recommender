
require 'rubygems'
require 'json'
require 'pp'
require 'matrix'

#!/usr/bin/env /home/ivanjoe/Projects/automatic_recommender/script/rails runner 
require '/home/ivanjoe/Projects/automatic_recommender/lib/matrix_builder/users_array.rb'
require '/home/ivanjoe/Projects/automatic_recommender/lib/matrix_builder/items_array.rb'

# Data has to come in matrix format
# Columns are representing the users
# Rows represent the items
=begin
data = {
  'James bond' => [1 -> 5, 5,0,5],
  'Mr. No' => [1 -> 5,0,3,4],
  '3' => [1 -> 3,4,0,3],
  '6' => [1 -> 5,4,5,5],
}
=end
class Array
  def key_by_value value
    return catch :return do
      self.each_with_index do |each, index|
        throw(:return, index) if each == value
      end
    end
  end
end

# Create a user-item matrix with the appropriate number of rows and columns
# Number of rows: number of items
#item_array = Rating.select(:item_id).collect{|rating| rating.item_id}.uniq
rownum = Items_array.size
# Number of columns: number of users
#user_array = Rating.select(:user_id).collect{|rating| rating.user_id}.uniq
colnum = Users_array.size
# Create matrix with the counted dimensions, fill with 0s
#user_item_matrix = Matrix.build(rownum, colnum){0}
# Number of columns should be smaller than number of rows
if Items_array.size < Users_array.size
  colnum = Items_array.size
  rownum = Users_array.size

  colname = "items"
  rowname = "users"
else
  rownum = Items_array.size
  colnum = Users_array.size

  colname = "users"
  rowname = "items"
end
user_item_array = colnum.times.collect{ rownum.times.collect {0} }

p "Number of rows:" + rownum.to_s + "(" + rowname + ")"
p "Number of columns:" + colnum.to_s + "(" + colname + ")"

# Fill in the item ratings
# If there are more items than users then switch the rows and columns
p "Array creation"
p Time.now.to_s
if Items_array.size < Users_array.size
  Users_array.each_with_index do |user_id, column|  
    ratings_per_user = Rating.find_all_by_user_id(user_id)
    ratings_per_user.each do |rating|
      row = Items_array.key_by_value(rating.item_id)
      # error handling
      user_item_array[column][row] = rating.rating
    end
  end
else # This is now our case
  Items_array.each_with_index do |item_id, column|  
    ratings_per_item = Rating.find_all_by_item_id(item_id)
    ratings_per_item.each do |rating|
      row = Users_array.key_by_value(rating.user_id)
      # error handling
      user_item_array[column][row] = rating.rating
    end
  end  
end
p Time.now.to_s
p "Array creation ended"

# Test, make the array smaller
# column numbers - items
user_item_array = user_item_array[0..20]

# colnumbers - users
user_item_array.map!{|x| x[0..19]}
p "User-Item matrix colnum:" + user_item_array.size.to_s
#p user_item_array.to_json

json = user_item_array.to_json

target = "user_item_array.json"

File.open(target, "w") do |f|
  f.write(json)
end
p "Counting.."
p Time.now.to_s
out = JSON.parse(%x|java -jar #{File.dirname(__FILE__)}/../java/recommender.jar #{target}|)

target = "calculated_matrices.json"
File.open(target, "w") do |f|
  f.write(out)
end

#pp out
p Time.now.to_s
p "Finished"
#pp rownum
#pp colnum
#pp user_item_matrix

# method similar users
# in  :  a user([Float])
# out :  [user]
=begin
def similar user
  out = JSON.parse(%x|java -jar #{File.dirname(__FILE__)}/recommender.jar #{FILE_IN}|)

  u = Matrix[*out[1]] #rows
  s = Matrix[*out[0]]
  vt = Matrix[*out[2]] #columns

  #pp u.column(0)
  u_collapsed  = Matrix.columns([u.column(0),u.column(1)])   # Items
  s_collapsed  = Matrix.columns([s.column(0),s.column(1)])
  vt_collapsed = Matrix.columns([vt.column(0),vt.column(1)]) # Users

  pp u_collapsed
  pp s_collapsed
  pp vt_collapsed

  #user.transpose * Matrix[u.column(0), u.column(1)]
  #p (s * Matrix[s.column(0), s.column(1)])

end

 similar_users = similar(Matrix[[5,5,0,0,0,5]])
=end
