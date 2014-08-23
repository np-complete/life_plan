# -*- coding: utf-8 -*-
module ApplicationHelper
  def toggle_watch_button(title, watching_ids)
    classes = ['make-switch', 'toggle-watch', "title_#{title.id}"]
    active =  watching_ids.include?(title.id)

    content_tag :div, class: classes do
      check_box_tag nil, '1', active, name: nil, id: nil, title_id: title.id
    end
  end
end
