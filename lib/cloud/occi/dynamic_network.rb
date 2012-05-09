# Copyright (c) 2012 Piston Cloud Computing, Inc.
# Copyright (c) 2012 ZHAW.

module Bosh::OcciCloud
  ##
  #
  class DynamicNetwork < Network

    ##
    # Creates a new dynamic network
    #
    # @param [String] name Network name
    # @param [Hash] spec Raw network spec
    def initialize(name, spec)
      super
    end

    ##
    # Configures OCCI Network resources.
    # @param [Fog::Compute::OpenStack] openstack Fog OpenStack Compute client
    # @param [Fog::Compute::OpenStack::Server] server OpenStack server to configure
    def configure(openstack, server)
      cloud_error("`configure' not implemented by #{self.class}")
    end

  end
end