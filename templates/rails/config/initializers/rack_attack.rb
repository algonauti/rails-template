# frozen_string_literal: true

class Rack::Attack
  class Request < ::Rack::Request
  end

  # Throttle all requests by IP (60rpm)
  #
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
  end
end
