# Copyright (c) 2012 Piston Cloud Computing, Inc.

require File.expand_path("../../spec_helper", __FILE__)

describe Bosh::OpenStackCloud::NetworkConfigurator do

  def set_security_groups(spec, security_groups)
    spec["cloud_properties"] = {
      "security_groups" => security_groups
    }
  end

  it "should raise an error if the spec isn't a hash" do
    lambda {
      Bosh::OpenStackCloud::NetworkConfigurator.new("foo")
    }.should raise_error ArgumentError
  end

  describe "security groups" do
    it "should only be extracted from dynamic network" do
      spec = {}
      spec["network_a"] = dynamic_network_spec
      set_security_groups(spec["network_a"], %w[foo])
      spec["network_b"] = vip_network_spec
      set_security_groups(spec["network_b"], %w[bar])

      nc = Bosh::OpenStackCloud::NetworkConfigurator.new(spec)
      nc.security_groups(nil).should == %w[foo]
    end

    it "should return the default groups if none are extracted" do
      spec = {}
      spec["network_a"] = dynamic_network_spec

      nc = Bosh::OpenStackCloud::NetworkConfigurator.new(spec)
      nc.security_groups(%w[foo]).should == %w[foo]
    end

    it "should return an empty list if no default group is set" do
      spec = {}
      spec["network_a"] = dynamic_network_spec

      nc = Bosh::OpenStackCloud::NetworkConfigurator.new(spec)
      nc.security_groups(nil).should == []
    end

    it "should raise an error when it isn't an array" do
      spec = {}
      spec["network_a"] = dynamic_network_spec
      set_security_groups(spec["network_a"], "foo")

      lambda {
        Bosh::OpenStackCloud::NetworkConfigurator.new(spec)
      }.should raise_error ArgumentError, "security groups must be an Array"
    end
  end
end