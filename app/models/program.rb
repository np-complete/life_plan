require 'syobocal'

class Program
  attr_accessor :id, :title_id, :channel_id, :start_at, :channel, :title

  def initialize(opt = {})
    opt.each {|k, v| send("#{k}=", v) }
  end

  def self.today
    programs = Rails.application.redis.get(:programs)
    unless programs
      programs = Syobocal::API.programs.map do |program|
        Program.new(program.to_h)
      end
      Rails.application.redis.setex(:programs, 15.minutes, programs)
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
