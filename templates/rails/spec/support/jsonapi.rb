# spec/spec_helpers.rb
require 'jsonapi/rspec'

module JSONAPISupport
  include JSONAPI::RSpec

  def response_body
    @response_body ||= JSON.parse(response.body, object_class: ActiveSupport::HashWithIndifferentAccess)
  end

  def response_data
    response_body[:data]
  end
end

RSpec.configure do |config|
  config.include JSONAPISupport, type: :controller

  # Support for documents with mixed string/symbol keys. Disabled by default.
  config.jsonapi_indifferent_hash = true
end
