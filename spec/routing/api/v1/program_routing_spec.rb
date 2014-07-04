require 'rails_helper'

describe Api::V1::ProgramsController do
  it 'routes to #index' do
    expect(get: "/api/v1/programs").to route_to("api/v1/programs#index", format: 'json')
  end
end
