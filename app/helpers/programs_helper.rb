module ProgramsHelper
  def anime_time_format(time)
    hour = time.hour
    day = time.day
    if hour < 5
      hour = hour + 24
      day = day - 1
    end
    time.strftime("#{hour}:%M")
  end
end
