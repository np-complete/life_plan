require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  describe 'GET #v1' do
    it do
      get :v1
      expect(response).to be_success
    end
  end
end
