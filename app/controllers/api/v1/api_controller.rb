module Api
  module V1
    class ApiController < ApplicationController
      doorkeeper_for :all
      respond_to :json

      def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id)
      end
    end
  end
end
