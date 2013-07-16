require "spec_helper"

describe TitlesController do
  describe "routing" do

    it "routes to #index" do
      get("/titles").should route_to("titles#index")
      get("/titles/all").should route_to("titles#index", :initial => "all")
      get("/titles/a").should route_to("titles#index", :initial => "a")
    end

  end
end
