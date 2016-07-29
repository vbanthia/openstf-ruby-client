require 'faraday'
require 'svelte'
require "openstf/version"
require "openstf/faraday/ext"

module OpenSTF
  module Client
    attr_accessor :service
    def self.init(host:, token:)
      authentication_middleware_stack =
          [[
              Faraday::Request::TokenAuthentication,
              token
          ]]
      @service = Svelte::Service.create(
          url: "http://#{host}/api/v1/swagger.json",
          module_name: 'Internal',
          options: { middleware_stack: authentication_middleware_stack,
                     host: host}
      )
      self.module_eval("include #{@service}")
    end
  end
end
