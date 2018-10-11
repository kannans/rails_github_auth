class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.avatar_url = auth.info.image
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      user.repos_url = auth.extra.raw_info.repos_url
      user.subscriptions_url = auth.extra.raw_info.subscriptions_url
      user.url = auth.extra.raw_info.url
      user.login = auth.info.login

      user.save!
    end
  end
end
