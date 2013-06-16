require 'spec_helper'

describe ChannelsController do
  it 'routes to #index' do
    get("/channels").should route_to("channels#index")
  end

  it 'routes to #create' do
    post("/channels").should route_to("channels#create")
  end

  it 'routes to #update' do
    put("/channels/1").should route_to("channels#update", :id => "1")
  end

  it 'routes to #destroy' do
    delete("/channels/1").should route_to("channels#destroy", :id => "1")
  end
end
