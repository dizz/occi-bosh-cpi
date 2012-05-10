# Copyright (c) 2012 Piston Cloud Computing, Inc.

module Bosh::OcciCloud
  ##
  #
  class Network
    include Bosh::OpenStackCloud::Helpers

    ##
    # Creates a new network
    #
    # @param [String] name Network name
    # @param [Hash] spec Raw network spec
    def initialize(name, spec)
      unless spec.is_a?(Hash)
        raise ArgumentError, "Invalid spec, Hash expected, " \
                             "#{spec.class} provided"
      end

      @logger = Bosh::Clouds::Config.logger

      @name = name
      @ip = spec["ip"]
      @cloud_properties = spec["cloud_properties"]
    end

    ##
    # Configures given server
    #
    # @param occi client
    # @param occi comupute instance
    def configure(occi, server)
      cloud_error("`configure' not implemented by #{self.class}")
    end

  end
end