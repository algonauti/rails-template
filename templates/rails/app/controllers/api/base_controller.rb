class Api::BaseController < ActionController::API
  before_action :doorkeeper_authorize!
end
