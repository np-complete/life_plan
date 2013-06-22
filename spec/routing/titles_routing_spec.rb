require "spec_helper"

describe TitlesController do
  describe "routing" do

    it "routes to #index" do
      get("/titles").should route_to("titles#index")
    end

  end
end
