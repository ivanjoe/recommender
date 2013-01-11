class GraphController < ApplicationController
  def show
    do_something para
  end

  def do_something x, y
    json_matrices = File.read(File.dirname(__FILE__) + "/../../calculated_matrices.json")

    calculated_matrices = JSON.parse(json_matrices)

    rows = []
    columns = []
    x_min = nil
    x_max = nil
    y_min = nil
    y_max = nil

    if params[:user_x].present? && params[:user_y].present?
      #head
      head = [["X", "Users", "Actual user"]]
      #rows
      #rows = calculated_matrices[1].map{|x| [x[0], x[1], nil, nil]}
=begin
      calculated_matrices[1].each do |x|
        rows.push([x[0], x[1], nil, nil])
        
        if x_min == nil or x_min > x[0]
          x_min = x[0]
        end

        if y_min == nil or y_min > x[1]
          y_min = x[1]
        end

        if x_max == nil or x_max < x[0]
          x_max = x[0]
        end

        if y_max == nil or y_max < x[1]
          y_max = x[1]
        end
      end
=end
      #columns
      #columns = calculated_matrices[2].map{|y| [y[0],nil,y[1], nil] }
      calculated_matrices[2].each do |y|
        columns.push([y[0], y[1], nil])

        if x_min == nil or x_min > y[0]
          x_min = y[0]
        end

        if y_min == nil or y_min > y[1]
          y_min = y[1]
        end

        if x_max == nil or x_max < y[0]
          x_max = y[0]
        end

        if y_max == nil or y_max < y[1]
          y_max = y[1]
        end
      end

      #user
      actual = [[params[:user_x].to_f, nil, params[:user_y].to_f]]

      if x_min > actual[0][0]
        x_min = actual[0][0]
      end

      if x_max < actual[0][0]
        x_max = actual[0][0]
      end

      if y_min > actual[0][2]
        y_min = actual[0][2]
      end

      if y_max < actual[0][2]
        y_max = actual[0][2]
      end

      @json = (head + rows + columns + actual)
      @x_min = x_min
      @x_max = x_max
      @y_min = y_min
      @y_max = y_max
    else
      #head
      head = [["X", "Row", "Column"]]
      #rows
      #rows = calculated_matrices[1].map{|x| [x[0], x[1], nil]}
      calculated_matrices[1].each do |x|
        rows.push([x[0], x[1], nil])
        
        if x_min == nil or x_min > x[0]
          x_min = x[0]
        end

        if y_min == nil or y_min > x[1]
          y_min = x[1]
        end

        if x_max == nil or x_max < x[0]
          x_max = x[0]
        end

        if y_max == nil or y_max < x[1]
          y_max = x[1]
        end
      end

      #columns
      #columns = calculated_matrices[2].map{|y| [y[0],nil,y[1]] }
      calculated_matrices[2].each do |y|
        columns.push([y[0], nil, y[1]])

        if x_min == nil or x_min > y[0]
          x_min = y[0]
        end

        if y_min == nil or y_min > y[1]
          y_min = y[1]
        end

        if x_max == nil or x_max < y[0]
          x_max = y[0]
        end

        if y_max == nil or y_max < y[1]
          y_max = y[1]
        end
      end

      @json = (head + rows + columns)
      @x_min = x_min
      @x_max = x_max
      @y_min = y_min
      @y_max = y_max
    end
  end

  def calculate_position
    # save the ratings
    # ?save many method
    # 
    require "./lib/matrix_builder/items_array.rb"

    ratings = []
    Items_array.each_with_index do |movie_id, index|
      rating = params['r_' + movie_id.to_s]
      ratings.push(rating.to_f)
      break if index == 20
    end
    
    coordinates = Rating.find_position ratings
    do_something x, y
    render 'show'
  end
end
