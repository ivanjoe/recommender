class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :movie_title
      t.date :release_date
      t.date :video_release_date
      t.string :imdb_url
      t.string :unknown
      t.boolean :action
      t.boolean :adventure
      t.boolean :animation
      t.boolean :children
      t.boolean :comedy
      t.boolean :crime
      t.boolean :documentary
      t.boolean :drama
      t.boolean :fantasy
      t.boolean :film_noir
      t.boolean :horror
      t.boolean :musical
      t.boolean :mystery
      t.boolean :romance
      t.boolean :sci_fi
      t.boolean :thriller
      t.boolean :war
      t.boolean :western

      t.timestamps
    end
  end
end
