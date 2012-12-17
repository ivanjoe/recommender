class Movie < ActiveRecord::Base
  attr_accessible :action, :adventure, :animation, :children, :comedy, :crime, :documentary, :drama, :fantasy, :film_noir, :horror, :imdb_url, :movie_title, :musical, :mystery, :release_date, :romance, :sci_fi, :thriller, :unknown, :video_release_date, :war, :western
end
