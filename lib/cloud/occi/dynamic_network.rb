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
    # @param occi client
    # @param occi compute instance
    def configure(occi, server)
      cloud_error("`configure' not implemented by #{self.class}")
    end

  end
end