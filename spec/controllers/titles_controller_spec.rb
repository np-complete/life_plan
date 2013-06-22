require 'spec_helper'


describe TitlesController do
  describe "GET index" do
    it "assigns all titles as @titles" do
      titles = FactoryGirl.create_list(:title, 10)
      get :index
      expect(assigns(:titles)).to eq titles
    end
  end
end
