class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  attr_accessible :provider, :uid, :name

  def self.find_for_google_oauth2(access_token, current_user)
    data = access_token.info
    user = User.where(provider: 'google', uid: access_token[:uid]).first
    unless user
      user = User.create(name: data["name"], uid: access_token[:uid], provider: 'google')
    end
    user
  end
end
