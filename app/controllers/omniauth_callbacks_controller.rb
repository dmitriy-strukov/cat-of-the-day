class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    process_callback
  end

  def twitter
    process_callback
  end

  private

  def process_callback
    oauth_data = request.env['omniauth.auth']

    sign_in_with_oauth_data(oauth_data) unless user_signed_in?

    current_user.register_social_profile({ uid: oauth_data.uid, service_name: oauth_data.provider },
                                         provider_attributes(oauth_data))

    redirect_to root_path
  end

  def provider_attributes(oauth_data)
    case params[:action]
    when 'twitter'
      twitter_attributes(oauth_data)
    when 'facebook'
      facebook_attributes(oauth_data)
    else
      raise NotImplementedError
    end
  end

  def twitter_attributes(oauth_data)
    {
      consumer_key:        oauth_data[:extra][:access_token].consumer.key,
      consumer_secret:     oauth_data[:extra][:access_token].consumer.secret,
      access_token:        oauth_data[:credentials][:token],
      access_token_secret: oauth_data[:credentials][:secret]
    }
  end

  def facebook_attributes(oauth_data)
    { token: oauth_data[:credentials][:token] }
  end

  def sign_in_with_oauth_data(data)
    sign_in :user, User.find_or_create_with_oauth(data)
  end
end
