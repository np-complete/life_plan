class Watching < ActiveRecord::Base
  attr_accessible :user_id, :title_id

  belongs_to :user
  belongs_to :title
end
