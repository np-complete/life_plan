require 'spec_helper'

describe Api::V1::ProgramsController do
  it 'routes to #index' do
    get("/api/v1/programs").should route_to("api/v1/programs#index", format: 'json')
  end
end
