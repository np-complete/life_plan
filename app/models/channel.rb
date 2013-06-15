class Channel < ActiveRecord::Base
  attr_accessible :name, :channel_group_id

  belongs_to :channel_group
end
