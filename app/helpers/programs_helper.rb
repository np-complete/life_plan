# -*- coding: utf-8 -*-
module ProgramsHelper
  def program_row(program, &block)
    classes = ["program", "title_#{program.title_id}"]
    if user_signed_in?
      classes << "hide"
      classes << "watchable" if @channel_ids.include?(program.channel_id)
      classes << "watching" if @title_ids.include?(program.title_id)
    end
    content_tag(:tr, :class => classes.join(" "), &block)
  end

  def toggle_watch_button(program)
    classes = ["btn", "toggle-watch", "title_#{program.title_id}"]
    classes << "active" if @title_ids.include?(program.title_id)
    content_tag :button, "Button", :class => classes.join(" "), :title_id => program.title_id
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
