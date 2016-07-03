require 'rails_helper'

describe ChannelsController do
  let(:user) { create :user }
  before { sign_in user }

  describe 'GET index' do
    it 'assigns channel_groups as @channel_groups' do
      channel_groups = create_list :channel_group, 3
      get :index
      expect(assigns[:channel_groups]).to eq channel_groups
    end

    it "assigns user's channels as @user_channel_ids" do
      user_channels = create_list :user_channel, 3, user: user
      get :index
      expect(assigns[:user_channel_ids]).to eq user_channels.map(&:channel_id)
    end
  end

  describe 'POST create' do
    it 'fetch channels from syobocal' do
      expect(Channel).to receive(:fetch_all)
      post :create
    end
  end

  describe 'PUT update' do
    let(:channel) { create :channel }
    it 'create user_channel' do
      put :update, params: { id: channel.to_param }
      expect(UserChannel.where(user_id: user.id, channel_id: channel.id)).to be_exists
    end
  end

  describe 'DELETE destroy' do
    let(:user_channel) { create :user_channel, user: user }
    it 'delete user_channel' do
      delete :destroy, params: { id: user_channel.channel.to_param }
      expect(UserChannel.where(user_id: user.id, channel_id: user_channel.channel_id)).not_to be_exists
    end
  end
end
