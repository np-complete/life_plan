require 'spec_helper'

describe ProgramsController do
  describe :index do
    let(:programs) { [] }
    it "assigns all programs as @program" do
      Rails.application.redis.stub(:get).with("life_plan:programs").and_return programs.to_json
      get :index
      expect(assigns[:programs]).to eq programs
    end
  end
end
