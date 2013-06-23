require 'spec_helper'

describe ProgramsController do
  describe :index do
    let(:programs) { [] }
    before do
      Rails.application.redis.stub(:get).with("life_plan:programs").and_return programs.to_json
    end

    it "assigns all programs as @program" do
      get :index
      expect(assigns[:programs]).to eq programs
    end

    describe :signed_in do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it "assigns user's channels as @channels" do
        channel_ids = FactoryGirl.create_list(:user_channel, 3, user: user).map(&:channel_id)
        get :index
        expect(assigns[:channel_ids]).to eq channel_ids
      end
    end
  end
end
