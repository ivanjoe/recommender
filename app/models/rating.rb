class Rating < ActiveRecord::Base
  attr_accessible :item_id, :rated_at, :rating, :user_id
end
