class HomeController < ApplicationController

  def index
    require Rails.root.to_s + '/lib/matrix_builder/items_array.rb'
    require Rails.root.to_s + '/lib/matrix_builder/users_array.rb'

    # List of movies with ratings
    @movies = Movie.find_all_by_movie_id Items_array[0..20]
    ratings = Rating.find_all_by_user_id_and_item_id 1000, Items_array[0..20]
    rating_vector = ratings.map {|x| x.rating }

    # Find position
    coordinates = Rating.find_position rating_vector

    # Find neighbours based on position
    neighbours = Rating.find_nearest_neighbours coordinates[0][0], coordinates[0][1]

    # Add the item if it has not been rated by the user
    # Find one-one item from the first 3 most similar user what has not been watched
    all_ratings = Rating.find_all_by_item_id_and_user_id Items_array[0..20], Users_array[0..19]
    
    @recommendations = {} 

    neighbours.each do |sim|
      index = sim[0]
      similarity = sim[1]

      # Get all the items that the neighbour rated
      neighbours_items = all_ratings.select {|rating| rating.user_id == Users_array[index]}

      # Sort the items by their ratings
      neighbours_items = neighbours_items.sort_by {|z| z.rating}
      neighbours_items.reverse!

      none_from_user = true
      neighbours_items.each do |item|
        # Find if the current user has already rated that item
        current_rating = ratings.select {|r| r.item_id == item.item_id}
        # Add the item to the recommended list if the rating is bigger than 3
        # and the user has not rated the item yet
        # and it is not yet on the list
        if item.rating >= 3 &&
          current_rating.first.rating == 0 &&
          @recommendations[item.item_id] == nil 
          recommendation = {
            :movie_id => item.item_id,
            :user_id => Users_array[index],
            :similarity => similarity
          }
          @recommendations[item.item_id] = recommendation
          break
        end
      end
      break if @recommendations.count == 3

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
