class ChannelGroup < ActiveRecord::Base
  has_many :channels

  default_scope { order(:id) }
end
