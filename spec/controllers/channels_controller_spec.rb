require 'spec_helper'

describe ChannelsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  describe :index do
    it 'assigns channel_groups as @channel_groups' do
      channel_groups = FactoryGirl.create_list(:channel_group, 3)
      get :index
      expect(assigns[:channel_groups]).to eq channel_groups
    end

    it "assigns user's channels as @user_channel_ids" do
      user_channels = FactoryGirl.create_list(:user_channel, 3, user: @user)
      get :index
      expect(assigns[:user_channel_ids]).to eq user_channels.map(&:channel_id)
    end
  end

  describe :create do
    it "fetch channels from syobocal" do
      Channel.should_receive(:fetch_all)
      post :create
    end
  end

  describe :update do
    it "create user_channel" do
      channel = FactoryGirl.create(:channel)
      put :update, :id => channel.id
      expect(UserChannel.where(:user_id => @user.id, :channel_id => channel.id).exists?).to be_true
    end
  end

  describe :destroy do
    it "create user_channel" do
      user_channel = FactoryGirl.create(:user_channel, user: @user)
      delete :destroy, :id => user_channel.channel_id
      expect(UserChannel.where(:user_id => @user.id, :channel_id => user_channel.channel_id).exists?).to be_false
    end
  end
end
