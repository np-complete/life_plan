module Oauth
  class ApplicationsController < Doorkeeper::ApplicationsController
    before_action :authenticate_user!

    def index
      @applications = current_user.oauth_applications.all
    end

    def new
      @application = current_user.oauth_applications.new
    end

    def create
      @application = current_user.oauth_applications.new(application_params)
      if @application.save
        flash[:notice] = I18n.t(:notice, scope: [:doorkeeper, :flash, :applications, :create])
        redirect_to oauth_application_url(@application)
      else
        render :new
      end
    end

    def update
      if @application.update(application_params)
        flash[:notice] = I18n.t(:notice, scope: [:doorkeeper, :flash, :applications, :update])
        redirect_to oauth_application_url(@application)
      else
        render :edit
      end
    end

    def destroy
      flash[:notice] = I18n.t(:notice, scope: [:doorkeeper, :flash, :applications, :destroy]) if @application.destroy
      redirect_to oauth_applications_url
    end

    protected

    def set_application
      @application = current_user.oauth_applications.find(params[:id])
    end
  end
end
