require 'syobocal'

class Channel < ActiveRecord::Base
  belongs_to :channel_group

  default_scope { order(:id) }

  def self.fetch_all
    channel_ids = Channel.all.map(&:id)
    channel_group_ids = ChannelGroup.all.map(&:id)
    channels = Syobocal::API.channels
    groups = channels.map { |channel| OpenStruct.new(name: channel[:group_name], id: channel[:group_id]) }.uniq
    channels = channels.map { |channel| OpenStruct.new(id: channel[:channel_id], name: channel[:name], channel_group_id: channel[:group_id]) }
    ChannelGroup.create groups.reject { |x| channel_group_ids.include?(x.id) }.map(&:to_h)
    Channel.create channels.reject { |x| channel_ids.include?(x.id) }.map(&:to_h)
  end
end
