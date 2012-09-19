#!/usr/bin/env /home/ivanjoe/Projects/automatic_recommender/script/rails runner

require 'rubygems'
require 'json'
require 'pp'
require 'matrix'

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
  '4' => [1 -> 0,0,5,3],
  '5' => [1 -> 5,4,4,5],
  '6' => [1 -> 5,4,5,5],
}
=end
def Array.key_by_value value
  return catch :return do
    self.each_with_index do |each, index|
      throw(:return, index) if each == value
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
colnum.times.collect 
# Fill in the item ratings

=begin
Users_array[0]
  ratings_per_user = Rating.find_by_user_id(Users.array)
  rating = ratings_per_user[0].item_id
  row = Items_array.find_by_value(item_id)
  Matrix(0,row) = rating
=end
Users_array.each_with_index do |user_id, column|  
  ratings_per_user = Rating.find_all_by_user_id(user_id)
  ratings_per_user.each do |rating|
    row = Items_array.find_by_value(rating.item_id)
    # error handling
    user_item_matrix(row, column) = rating.rating
  end
end

pp user_item_matrix

#pp rownum
#pp colnum
#pp user_item_matrix

# method similar users
# in  :  a user([Float])
# out :  [user]
=begin
def similar user
  out = JSON.parse(%x|java -jar #{File.dirname(__FILE__)}/recommender.jar #{FILE_IN}|)

  u = Matrix[*out[1]]
  s = Matrix[*out[0]]
  vt = Matrix[*out[2]]

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
