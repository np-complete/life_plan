require 'syobocal'

class Channel < ActiveRecord::Base
  attr_accessible :id, :name, :channel_group_id

  belongs_to :channel_group

  def self.fetch_all
    Channel.destroy_all
    ChannelGroup.destroy_all

    channels = Syobocal::API.channels

    groups =  channels.map do |channel|
      {
        name: channel[:group_name],
        id: channel[:group_id]
      }
    end.uniq

    ChannelGroup.create groups

    channels = channels.map do |channel|
      {
        name: channel[:name],
        id: channel[:channel_id],
        channel_group_id: channel[:group_id]
      }
    end
    Channel.create channels
  end
end
