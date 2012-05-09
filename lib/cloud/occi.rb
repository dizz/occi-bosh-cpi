# Copyright (c) 2012 ZHAW.

module Bosh
  module OcciCloud; end
end

# This needs to be replaced.
# This is the OS client
require "fog"
#

require "httpclient"
require "pp"
require "set"
require "tmpdir"
require "uuidtools"
require "yajl"

require "common/thread_pool"
require "common/thread_formatter"

require "cloud"
require "cloud/occi/helpers"
require "cloud/occi/cloud"
require "cloud/occi/registry_client"
require "cloud/occi/version"

require "cloud/occi/network_configurator"
require "cloud/occi/network"
require "cloud/occi/dynamic_network"
require "cloud/occi/vip_network"

module Bosh
  module Clouds
    Occi = Bosh::OcciCloud::Cloud
    Occi = Occi # Alias needed for Bosh::Clouds::Provider.create method
  end
end
