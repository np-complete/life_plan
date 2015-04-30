require 'rails_helper'

describe ProgramsController do
  it 'routes to #index' do
    expect(get: '/').to route_to('top#index')
    expect(get: '/programs').to route_to('programs#index')
    expect(get: '/programs.json').to route_to('programs#index', format: 'json')
  end
end
