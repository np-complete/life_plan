class TitlesController < ApplicationController
  def index
    @titles = Title.page params[:page]
    @titles = @titles.begin_with params[:initial] if params[:initial]

    @watching_ids = current_user.titles.where(id: @titles.map(&:id)).map(&:id)

    respond_to do |format|
      format.html
    end
  end

  def update
    Watching.create(user_id: current_user.id, title_id: params[:id])
    render :json => :ok
  end

  def destroy
    Watching.where(user_id: current_user.id, title_id: params[:id]).delete_all
    render :json => :ok
  end
end
