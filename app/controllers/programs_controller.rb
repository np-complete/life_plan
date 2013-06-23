class ProgramsController < ApplicationController
  def index
    @programs = Program.today
    if user_signed_in?
      @channel_ids = current_user.channels.map(&:id)
      @title_ids   = current_user.titles.map(&:id)
    end
  end
end
