class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  before_filter :authenticate_user!

  def index
    @applications = current_user.oauth_applications.all
  end

  def new
    @application = current_user.oauth_applications.new
  end

  def create
    @application = current_user.oauth_applications.new(params[:application])
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      respond_with [:oauth, @application]
    else
      render :new
    end
  end

  def show
    @application = current_user.oauth_applications.find(params[:id])
  end

  def edit
    @application = current_user.oauth_applications.find(params[:id])
  end

  def update
    @application = current_user.oauth_applications.find(params[:id])
    if @application.update_attributes(params[:application])
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :update])
      respond_with [:oauth, @application]
    else
      render :edit
    end
  end

  def destroy
    @application = current_user.oauth_applications.find(params[:id])
    flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :destroy]) if @application.destroy
    redirect_to oauth_applications_url
  end
end
