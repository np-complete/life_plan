require 'syobocal'

class Program
  attr_accessor :id, :title_id, :channel_id, :start_at, :channel, :title

  @@key_name = "life_plan:programs"

  def initialize(opt = {})
    opt.each {|k, v| send("#{k}=", v) }
  end

  def start_at=(time)
    case time
    when String
      time = Time.zone.parse(time)
    when Integer
      time = Time.zone.at(time)
    end
    @start_at = time.in_time_zone(ActiveSupport::TimeZone["Tokyo"])
  end

  def self.today
    programs_json = Rails.application.redis.get(@@key_name)
    unless programs_json
      programs_json = Syobocal::API.programs.map(&:to_h).to_json
      Rails.application.redis.setex(@@key_name, 15.minutes, programs_json)
    end

    programs = JSON.parse(programs_json).map do |program|
      Program.new(program)
    end

    channels = Channel.find(programs.map(&:channel_id)).map{|x| [x.id, x]}
    titles = Title.find(programs.map(&:title_id)).map{|x| [x.id, x]}
    programs.each do |program|
      program.channel = channels.assoc(program.channel_id).last
      program.title = titles.assoc(program.title_id).last
    end

    programs
  end
end
