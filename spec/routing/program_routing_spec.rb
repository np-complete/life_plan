require 'rails_helper'

describe TitlesController do
  it 'routes to #index' do
    expect(get: '/titles').to route_to('titles#index')
  end

  it 'routes to #update' do
    expect(put: '/titles/1').to route_to('titles#update', id: '1')
  end

  it 'routes to #destroy' do
    expect(delete: '/titles/1').to route_to('titles#destroy', id: '1')
  end
end
