class GraphController < ApplicationController
  def show
    json_matrices = File.read(File.dirname(__FILE__) + "/../../calculated_matrices.json")

    calculated_matrices = JSON.parse(json_matrices)

    #head
    head = [["X", "Row", "Column", "Actual user"]]
    #rows
    rows = calculated_matrices[1].map{|x| [x[0], x[1], nil, nil]}
    #columns
    columns = calculated_matrices[2].map{|y| [y[0],nil,y[1], nil] }

    #user
    actual = [[0.6, nil, nil, 0.5]]

    @json = (head + rows + columns+actual)   
  end
end
