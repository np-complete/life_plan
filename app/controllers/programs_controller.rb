class ProgramsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!, only: [:watching]

  def index
    @programs = Program.today
    if user_signed_in?
      @channel_ids = current_user.channels.map(&:id)
      @title_ids   = current_user.titles.map(&:id)
    end

    respond_with @programs
  end

  def watching
    @title_ids = current_user.titles.map(&:id)
    respond_with @title_ids
  end
end
