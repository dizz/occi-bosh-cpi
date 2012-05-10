# Copyright (c) 2012 Piston Cloud Computing, Inc.

module Bosh::OcciCloud
  ##
  #
  class VipNetwork < Network

    ##
    # Creates a new vip network
    #
    # @param [String] name Network name
    # @param [Hash] spec Raw network spec
    def initialize(name, spec)
      super
    end

    ##
    # Configures vip network
    # Here we need to issue an OCCI request for the allocation of
    # a floating IP. 
    # See: http://wiki.openstack.org/occi#Allocate_Floating_IP_to_VM
    # The Fog client is used to interact with OpenStack.
    # Something similar is needed for OCCI
    #
    # @param occi client
    # @param occi compute instance
    def configure(occi, server)
      if @ip.nil?
        cloud_error("No IP provided for vip network `#{@name}'")
      end

      @logger.info("Associating instance `#{server.id}' " \
                   "with floating IP `#{@ip}'")

      # Check if the OCCI floating IP is allocated. If true, check
      # if it is associated to any server, so we can disassociate it
      # before associating it to the new server.
      address_id = nil
      addresses = occi.addresses
      addresses.each do |address|
        if address.ip == @ip
          address.disassociate unless address.instance_id.nil?
          address.associate(server)
          address_id = address.id
          break
        end
      end
      if address_id.nil?
        cloud_error("OCCI CPI: floating IP #{@ip} not allocated")
      end
    end

  end
end