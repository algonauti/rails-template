class Api::BaseController < ActionController::API
  include AccessibleResource

  #
  # Defines mimes that are rendered by default when invoking
  # respond_with.
  #
  respond_to :json
end
