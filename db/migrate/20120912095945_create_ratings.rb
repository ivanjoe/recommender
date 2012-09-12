class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :rating
      t.datetime :rated_at

      t.timestamps
    end
  end
end
