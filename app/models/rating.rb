class Rating < ActiveRecord::Base
  require 'matrix'
    
  attr_accessible :item_id, :rated_at, :rating, :user_id
  validates_uniqueness_of :item_id, :scope => [:user_id]

  def self.find_position ratings 
    json_matrices = File.read(File.dirname(__FILE__) + "/../../calculated_matrices.json")

    calculated_matrices = JSON.parse(json_matrices)

    # The S matrix
    s = calculated_matrices[0][0..1].map!{|x| x[0..1]}
    # Create a Matrix from the array
    s_matrix = Matrix.rows(s)

    # The rows U matrix
    u = calculated_matrices[1].map!{|y| y[0..1]}
    # Create a Matrix from the array
    u_matrix = Matrix.rows(u)

    # The columns V.transpose
    #vtrans = calculated_matrices[2].map!{|z| z[0..1]}
    user = Matrix.row_vector(ratings)
    
    position = user * u_matrix * s_matrix **(-1)
    position.to_a    
  end


end
