class Api::DocumentsController < ApplicationController
  def v1
    now = Time.now.to_i
    @programs = [
      { channel: 'ch_1', title: "title_1", no: 12, subtitle: "subtitle_1", start_at: now},
      { channel: 'ch_2', title: "title_2", no: 11, subtitle: "subtitle_2", start_at: now + 1800}
    ]
  end
end
