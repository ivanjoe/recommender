
require 'rubygems'
require 'json'
require 'pp'
require 'matrix'

json_matrices = File.read(File.dirname(__FILE__) + "/../../calculated_matrices.json") 

calculated_matrices = JSON.parse(json_matrices)

# head
head = ["X", "Rows", "Columns"]
# rows
rows = calculated_matrices[1].map{|x| [x[0],x[1],nil]}

# columns
columns = calculated_matrices[2].map{|y| [y[0],nil,y[1]] }

p (head + rows + columns)

