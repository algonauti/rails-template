Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    User.find_by_id(session[:user_id]) || head(:unauthorized)
  end

  # Specify what grant flows are enabled in array of Strings. The valid
  # strings and the flows they enable are:
  #
  # "authorization_code" => Authorization Code Grant Flow
  # "implicit"           => Implicit Grant Flow
  # "password"           => Resource Owner Password Credentials Grant Flow
  # "client_credentials" => Client Credentials Grant Flow
  #
  # If not specified, Doorkeeper enables authorization_code and
  # client_credentials.
  #
  # implicit and password grant flows have risks that you should understand
  # before enabling:
  #   http://tools.ietf.org/html/rfc6819#section-4.4.2
  #   http://tools.ietf.org/html/rfc6819#section-4.4.3
  #
  grant_flows %w(password)

  use_refresh_token

  resource_owner_from_credentials do
    user = if params[:username].present?
        User.find_for_database_authentication(username: params[:username])
      elsif params[:email].present?
        User.find_for_database_authentication(email: params[:email])
      end

    if user && user.valid_for_authentication? { user.valid_password_and_allowed_ip?(params[:password], request.remote_ip) }
      request.env["warden"].cookies.permanent.signed["user.id"] = user.id
      request.env["warden"].cookies.permanent.signed["user.expires_at"] = 5.days.from_now
      user
    end
  end
end
