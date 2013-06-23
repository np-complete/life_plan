module ProgramsHelper
  def program_row(program, &block)
    classes = ["program"]
    if user_signed_in?
      classes << "hide"
      if @channel_ids.include?(program.channel_id)
        classes << (@title_ids.include?(program.title_id) ? "watching" : "watchable")
      end
    end
    content_tag(:tr, :class => classes.join(" "), &block)
  end

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
