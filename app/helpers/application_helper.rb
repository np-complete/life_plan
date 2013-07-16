# -*- coding: utf-8 -*-
module ApplicationHelper
  def toggle_watch_button(title, watching_ids)
    classes = ["btn", "toggle-watch", "title_#{title.id}"]
    if watching_ids.include?(title.id)
      classes << "active"
      button_name = '追加済み'
    else
      button_name = '追加する'
    end
    content_tag :button, button_name, :class => classes.join(" "), :title_id => title.id
  end
end
