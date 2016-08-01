module OpenSTF
  class Device
    DEVICE_TIMEOUT = 60 * 60 * 2 * 1000 # 2hours, milli second unit
    attr_accessor :remote_connect_url, :data, :serial

    def initialize(data: {}, serial: nil)
      @data   = data
      @serial = data['serial'] || serial
    end

    def connect
      device = ::OpenSTF::Client::Devices.get_device_by_serial(
          serial: @serial,
      fields: 'serial,present,ready,using,owner').body['device']
      if !device['present'] || !device['ready'] || device['using'] || device['owner']
        raise("Device #{@serial} is not available")
      end

      added = ::OpenSTF::Client::User::Devices.add_user_device(
          serial: @serial,
          timeout:DEVICE_TIMEOUT
      ).body

      raise("Could not connect to device #{@serial}")unless added['success']

      connected = ::OpenSTF::Client::User::Devices::RemoteConnect.remote_connect_user_device_by_serial(serial: @serial).body

      raise("#{connected['description']}: #{@serial}") unless connected['success']

      return connected['remoteConnectUrl']
    end

    def disconnect
      user_devices = OpenSTF::Client::User::Devices
                         .get_user_device_by_serial(
                             serial: @serial,
                             fields: 'serial,present,ready,using,owner'
                         ).body
      raise("#{user_devices['description']}: #{@serial}") unless user_devices['success']

      deleted = OpenSTF::Client::User::Devices
                    .delete_user_device_by_serial(
                        serial: @serial
                    ).body

      raise("#{deleted['description']}: #{@serial}") unless deleted['success']
    end
  end

end
