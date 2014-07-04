require 'rails_helper'

describe ProgramsController do
  describe "GET index" do
    let(:programs) { [] }
    before do
      Rails.application.redis.stub(:get).with("life_plan:programs").and_return programs.to_json
    end

    it "assigns all programs as @program" do
      get :index
      expect(assigns[:programs]).to eq programs
    end

    context "signed in" do
      let(:user) { create :user }
      before { sign_in user }

      it "assigns user's watchable channel ids as @channels" do
        user_channels = create_list :user_channel, 3, user: user
        get :index
        expect(assigns[:channel_ids]).to eq user_channels.map(&:channel_id)
      end

      it "assigns user's watching title ids as @title_ids" do
        watchings = create_list :watching, 3, user: user
        get :index
        expect(assigns[:title_ids].sort).to eq watchings.map(&:title_id).sort
      end
    end
  end
end
