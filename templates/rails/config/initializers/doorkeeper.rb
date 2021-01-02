Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # If you are planning to use Doorkeeper in Rails API-only application, then you might
  # want to use API mode that will skip all the views management and change the way how
  # Doorkeeper responds to a requests.
  #
  api_only

  # The controller +Doorkeeper::ApplicationController+ inherits from.
  # Defaults to +ActionController::Base+ unless +api_only+ is set, which changes the default to
  # +ActionController::API+. The return value of this option must be a stringified class name.
  # See https://doorkeeper.gitbook.io/guides/configuration/other-configurations#custom-base-controller
  #
  base_controller 'Api::BaseController'

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

  # Issue access tokens with refresh token (disabled by default), you may also
  # pass a block which accepts `context` to customize when to give a refresh
  # token or not. Similar to +custom_access_token_expires_in+, `context` has
  # the following properties:
  #
  # `client` - the OAuth client application (see Doorkeeper::OAuth::Client)
  # `grant_type` - the grant type of the request (see Doorkeeper::OAuth)
  # `scopes` - the requested scopes (see Doorkeeper::OAuth::Scopes)
  #
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
