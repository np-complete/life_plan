require 'spec_helper'

describe TitlesController do
  it 'routes to #index' do
    get("/titles").should route_to("titles#index")
  end

  it 'routes to #update' do
    put("/titles/1").should route_to("titles#update", :id => "1")
  end

  it 'routes to #destroy' do
    delete("/titles/1").should route_to("titles#destroy", :id => "1")
  end
end
