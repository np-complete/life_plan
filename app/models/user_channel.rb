class UserChannel < ActiveRecord::Base
  attr_accessible :user_id, :channel_id
  belongs_to :user
  belongs_to :channel
end
