require 'faraday'

module Faraday
  class Request::TokenAuthentication < Request.load_middleware(:authorization)
    def self.header(token, options = nil)
      options ||= {}
      options[:token] = token
      super(:Bearer, token)
    end
  end
end
