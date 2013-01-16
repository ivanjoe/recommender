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

  def self.find_nearest_neighbours x,y
    json_matrices = File.read(Rails.root.to_s + "/calculated_matrices.json")
    
    calculated_matrices = JSON.parse(json_matrices)

    users2 = calculated_matrices[2].map!{|x| x[0..1]}
    
    result = {}
    count = 0
    # Cosine similarity
    users2.each do |u|
      dot_product = ((u[0] * x) + (u[1] * y))
      magnitude = (Math.sqrt(u[0]**2 + u[1]**2) * Math.sqrt(x**2 + y**2))

      similarity = (dot_product / magnitude)

      result[count] = similarity
      count += 1
    end

    ordered = result.sort_by{|index, similarity| similarity }
    ordered.reverse!
  end

end
