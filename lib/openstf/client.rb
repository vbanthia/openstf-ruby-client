require 'faraday'
require 'svelte'
require 'openstf/version'
require 'openstf/faraday/ext'
require 'openstf/device'

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
      return Service.new(@service)
    end

    class Service
      def initialize(service)
        @service = service
      end

      def fetch_available_devices
        devices = OpenSTF::Client::Devices.get_devices.body['devices']

        available = devices.reject do |device|
          !device['present'] || !device['ready'] || device['using'] || device['owner']
        end

        @devices = available.map do |d|
          Device.new(data: d, serial: d['serial'])
        end

        @devices
      end

      def connect_device(serial:)
        d = Device.new(serial: serial)
        d.connect
      end

      def disconnect_device(serial:)
        d = Device.new(serial: serial)
        d.disconnect
      end
    end
  end
end
