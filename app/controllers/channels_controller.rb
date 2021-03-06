class ChannelsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @channel_groups = ChannelGroup.includes(:channels)
    @user_channel_ids = user_signed_in? ? current_user.channels.map(&:id) : []
    respond_with @channel_groups
  end

  def create
    Channel.fetch_all
    render json: :ok
  end

  def update(id)
    UserChannel.create(user_id: current_user.id, channel_id: id)
    render json: :ok
  end

  def destroy(id)
    UserChannel.where(user_id: current_user.id, channel_id: id).delete_all
    render json: :ok
  end
end
