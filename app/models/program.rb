# frozen_string_literal: true
require 'syobocal'

class Program
  attr_accessor :id, :title_id, :channel_id, :start_at, :channel, :title, :no, :subtitle

  KEY_NAME = 'life_plan:programs'.freeze

  def initialize(opt = {})
    opt.each { |k, v| send("#{k}=", v) }
  end

  def start_at=(time)
    case time
    when String
      time = ActiveSupport::TimeZone['Tokyo'].parse(time)
    when Integer
      time = ActiveSupport::TimeZone['Tokyo'].at(time)
    end
    @start_at = time
  end

  def self.today
    programs = JSON.parse(programs_json).map { |program| Program.new(program) }
    channels = fetch_channels(programs)
    titles = Title.find(programs.map(&:title_id)).map { |x| [x.id, x] }
    programs.each do |program|
      program.channel = channels.assoc(program.channel_id).last
      program.title = titles.assoc(program.title_id).last
    end

    programs
  end

  def as_json(_options = nil)
    {
      channel: channel.name,
      start_at: start_at.to_i,
      title: title.name,
      no: no,
      subtitle: subtitle
    }
  end

  def self.programs_json
    programs_json = Rails.application.redis.get(KEY_NAME)
    return programs_json if programs_json
    programs_json = Syobocal::API.programs.map(&:to_h).to_json
    Rails.application.redis.setex(KEY_NAME, 15.minutes, programs_json)
    programs_json
  end

  def self.fetch_channels(programs)
    Channel.find(programs.map(&:channel_id)).map { |x| [x.id, x] }
  rescue
    Channel.fetch_all
    Channel.find(programs.map(&:channel_id)).map { |x| [x.id, x] }
  end
end
