require 'spec_helper'

describe TitlesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/titles').to route_to('titles#index')
      expect(get: '/titles/all').to route_to('titles#index', initial: 'all')
      expect(get: '/titles/a').to route_to('titles#index', initial: 'a')
    end
  end
end
