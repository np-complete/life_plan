class Api::V1::ApiController < ApplicationController
  doorkeeper_for :all
  respond_to :json

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id)
  end
end
