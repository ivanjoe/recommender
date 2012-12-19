class RemoveVideoReleaseDateFromMovies < ActiveRecord::Migration
  def up
    remove_column :movies, :video_release_date
  end

  def down
    add_column :movies, :video_release_date, :date
  end
end
