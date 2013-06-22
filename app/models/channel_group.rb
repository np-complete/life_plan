class ChannelGroup < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :channels

  default_scope order(:id)

end
