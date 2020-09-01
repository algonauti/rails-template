module DoorkeeperHelpers
  extend ActiveSupport::Concern

  def doorkeeper_sign_in(user)
    allow(controller).to receive(:doorkeeper_token).and_return(
      Doorkeeper::AccessToken.create!(resource_owner_id: user.id)
    )
  end
end

RSpec.configure do |config|
  config.include DoorkeeperHelpers, type: :controller
end
