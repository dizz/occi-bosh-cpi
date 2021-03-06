# Copyright (c) 2012 Piston Cloud Computing, Inc.

require File.expand_path("../../spec_helper", __FILE__)

describe Bosh::OpenStackCloud::Cloud do

  before(:each) do
     @registry = mock_registry
   end

  it "deletes an OpenStack server" do
    server = double("server", :id => "i-foobar")

    cloud = mock_cloud do |openstack|
      openstack.servers.should_receive(:get).with("i-foobar").and_return(server)
    end

    server.should_receive(:state).and_return(:active)
    server.should_receive(:destroy).and_return(true)
    cloud.should_receive(:wait_resource).with(server, :active, :terminated, :state)

    @registry.should_receive(:delete_settings).with("i-foobar")

    cloud.delete_vm("i-foobar")
  end
end
