class TitlesController < ApplicationController
  def index
    @titles = Title.page params[:page]

    respond_to do |format|
      format.html
    end
  end
end
