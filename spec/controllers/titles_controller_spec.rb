require 'spec_helper'

describe TitlesController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "assigns all titles as @titles" do
      titles = FactoryGirl.create_list(:title, 10)
      get :index
      expect(assigns(:titles)).to eq titles
    end
  end

  describe :update do
    it "create watching" do
      title = FactoryGirl.create(:title)
      put :update, :id => title.id
      expect(Watching.where(:user_id => @user.id, :title_id => title.id).exists?).to be_true
    end
  end

  describe :destroy do
    it "create user_channel" do
      watching = FactoryGirl.create(:watching, user: @user)
      delete :destroy, :id => watching.title_id
      expect(Watching.where(:user_id => @user.id, :title_id => watching.title_id).exists?).to be_false
    end
  end
end
