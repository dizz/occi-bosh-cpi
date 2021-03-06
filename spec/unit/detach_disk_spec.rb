# Copyright (c) 2012 Piston Cloud Computing, Inc.

require File.expand_path("../../spec_helper", __FILE__)

describe Bosh::OpenStackCloud::Cloud do

  before(:each) do
    @registry = mock_registry
  end

  it "detaches an OpenStack volume from a server" do
    server = double("server", :id => "i-test")
    volume = double("volume", :id => "v-foobar")
    volume_attachments = double("body", :body => {"volumeAttachments" => [{"volumeId" => "v-foobar"}, {"volumeId" => "v-barfoo"}]})

    cloud = mock_cloud do |openstack|
      openstack.servers.should_receive(:get).with("i-test").and_return(server)
      openstack.volumes.should_receive(:get).with("v-foobar").and_return(volume)
      openstack.should_receive(:get_server_volumes).and_return(volume_attachments)
    end

    volume.should_receive(:status).and_return(:"in-use")
    volume.should_receive(:detach).with(server.id, "v-foobar").and_return(true)
    cloud.should_receive(:wait_resource).with(volume, :"in-use", :available)

    old_settings = {
      "foo" => "bar",
      "disks" => {
        "persistent" => {
          "v-foobar" => "/dev/vdb",
          "v-barfoo" => "/dev/vdc"
        }
      }
    }

    new_settings = {
      "foo" => "bar",
      "disks" => {
        "persistent" => {
          "v-barfoo" => "/dev/vdc"
        }
      }
    }

    @registry.should_receive(:read_settings).with("i-test").and_return(old_settings)
    @registry.should_receive(:update_settings).with("i-test", new_settings)

    cloud.detach_disk("i-test", "v-foobar")
  end

  it "raises an error when volume is not attached to a server" do
    server = double("server", :id => "i-test")
    volume = double("volume", :id => "v-barfoo")
    volume_attachments = double("body", :body => {"volumeAttachments" => [{"volumeId" => "v-foobar"}]})

    cloud = mock_cloud do |openstack|
      openstack.servers.should_receive(:get).with("i-test").and_return(server)
      openstack.volumes.should_receive(:get).with("v-barfoo").and_return(volume)
      openstack.should_receive(:get_server_volumes).and_return(volume_attachments)
    end

    expect {
      cloud.detach_disk("i-test", "v-barfoo")
    }.to raise_error(Bosh::Clouds::CloudError, /is not attached to server/)
  end

end
