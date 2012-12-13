class MatrixPrettyprinter
  def some_method
    rows = []
    columns = []
    x_min = nil
    x_max = nil
    y_min = nil
    y_max = nil

    if params[:user]
      #head
      head = [["X", "Row", "Column", "Actual user"]]
      #rows
      #rows = calculated_matrices[1].map{|x| [x[0], x[1], nil, nil]}
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
      
      #columns
      #columns = calculated_matrices[2].map{|y| [y[0],nil,y[1], nil] }
      calculated_matrices[2].each do |y|
        columns.push([y[0], nil, y[1], nil])

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
      actual = [[0.333, nil, nil, 0.5]]

      @json = (head + rows + columns + actual)
      @x_min = x_min
      @x_max = x_max
      @y_min = y_min
      @y_max = y_max
    else
      #head
      head = [["X", "Row", "Column"]]
      #rows
      rows = calculated_matrices[1].map{|x| [x[0], x[1], nil]}
      #columns
      columns = calculated_matrices[2].map{|y| [y[0],nil,y[1]] }
      @json = (head + rows + columns)
    end

  end
end
