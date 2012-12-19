class HomeController < ApplicationController

  def index
    require '/home/ivanjoe/Projects/automatic_recommender/lib/matrix_builder/items_array.rb'

    @movies = Array.new
    Items_array.each_with_index do |item, index|
      @movies.push(Movie.find_by_movie_id(item))
      break if index == 20
    end
  end

end
