class HomeController < ApplicationController

  def index
    require Rails.root.to_s + '/lib/matrix_builder/items_array.rb'

    @movies = Array.new
    Items_array.each_with_index do |item, index|
      @movies.push(Movie.find_by_movie_id(item))
      break if index == 20
    end
  end

  def submit
    ratings = params[:ratings]
    
    ratings.each_with_index do |(key,value), index|
      rating = Rating.find_or_create_by_item_id_and_user_id key.to_i, 1000
      rating.rating = value.to_i
      rating.rated_at = Time.now
      rating.save
    end

    redirect_to root_path
  end

end
