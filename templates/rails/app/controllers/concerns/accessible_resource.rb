module AccessibleResource
  extend ActiveSupport::Concern

  included do
    include Pundit

    #
    # Authenticated resource owner
    #
    before_action :doorkeeper_authorize!
  end

  protected

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
