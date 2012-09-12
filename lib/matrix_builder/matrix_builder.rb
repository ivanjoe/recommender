require 'rubygems'
require 'json'
require 'pp'
require 'matrix'

# Data has to come in matrix format
# Columns are representing the users
# Rows represent the items
data = {
  'James bond' => [1 -> 5, 5,0,5],
  'Mr. No' => [1 -> 5,0,3,4],
  '3' => [1 -> 3,4,0,3],
  '4' => [1 -> 0,0,5,3],
  '5' => [1 -> 5,4,4,5],
  '6' => [1 -> 5,4,5,5],
}

# Create a user-item matrix with the appropriate number of rows and columns
# Number of rows: number of items
rownum = Rating.select(:item_id).collect{|rating| rating.item_id}.uniq.size
# Number of columns: number of users
colnum = Rating.select(:user_id).collect{|rating| rating.user_id}.uniq.size
# Create matrix with the counted dimensions, fill with 0s


# method similar users
# in  :  a user([Float])
# out :  [user]

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

