module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)
      if @user.persisted?
        sign_in :user, @user
        flash[:notice] = t 'view.global.welcome-message'
      end
      redirect_to root_path
    end
  end
end
