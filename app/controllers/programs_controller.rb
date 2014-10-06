class ProgramsController < ApplicationController
  respond_to :html, :json

  def index
    @programs = Program.today
    if user_signed_in?
      @channel_ids = current_user.channels.map(&:id)
      @title_ids   = current_user.titles.map(&:id)
    end

    respond_with @programs
  end
end
