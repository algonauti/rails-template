class Api::BaseController < ActionController::API
  include AccessibleResource

  #
  # Force to use :jsonapi request format
  #
  before_action { request.format = :jsonapi }

  #
  # Defines mimes that are rendered by default when invoking
  # respond_with.
  #
  respond_to :jsonapi

  protected

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
