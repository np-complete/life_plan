class Api::V1::ApiController < ApplicationController
  doorkeeper_for :all, :if => lambda { request.xhr? }
  respond_to :json

  def current_resource_owner
    return current_user if current_user.present?
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
