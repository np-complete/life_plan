class TitlesController < ApplicationController
  respond_to :html, :json

  def index(page: 1, media: nil, initial: nil)
    @titles = Title.page(page)
    case initial
    when 'all'
    when  nil, 'current'
      @titles = @titles.current
    else
      @titles = @titles.begin_with(initial) if initial
    end
    @titles = @titles.send(media) if media && Title::Media.valid?(media)
    @watching_ids = current_user.titles.where(id: @titles.map(&:id)).map(&:id)

    respond_with @titles
  end

  def update(id)
    Watching.create(user_id: current_user.id, title_id: id)
    render json: :ok
  end

  def destroy(id)
    Watching.where(user_id: current_user.id, title_id: id).delete_all
    render json: :ok
  end
end
