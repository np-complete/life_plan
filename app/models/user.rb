class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  attr_accessible :provider, :uid, :name

  has_many :user_channels
  has_many :channels, :through => :user_channels
  has_many :watchings
  has_many :titles, :through => :watchings
  has_many :oauth_applications, :class_name => Doorkeeper::Application, :as => :owner

  def self.find_for_google_oauth2(access_token, current_user)
    data = access_token.info
    user = User.where(provider: 'google', uid: access_token[:uid]).first
    user = User.create(name: data["name"], uid: access_token[:uid], provider: 'google') unless user
    user
  end
end
