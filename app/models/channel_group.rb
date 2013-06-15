class ChannelGroup < ActiveRecord::Base
  attr_accessible :name
  has_many :channels
end
