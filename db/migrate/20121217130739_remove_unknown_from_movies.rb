class RemoveUnknownFromMovies < ActiveRecord::Migration
  def up
    remove_column :movies, :unknown
  end

  def down
    add_column :movies, :unknown, :string
  end
end
