# Copyright (c) 2012 Piston Cloud Computing, Inc.
# Copyright (c) 2012 ZHAW

require File.dirname(__FILE__) + "/lib/cloud/occi/version"

Gem::Specification.new do |s|
  s.name         = "bosh_occi_cpi"
  s.version      = Bosh::OcciCloud::VERSION
  s.platform     = Gem::Platform::RUBY
  s.summary      = "BOSH OCCI CPI"
  s.description  = s.summary
  s.author       = "Andy Edmonds"
  s.email        = "andrew.edmonds@zhaw.ch"
  s.homepage     = "http://www.zhaw.ch"

  s.files        = `git ls-files -- bin/* lib/*`.split("\n") + %w(README Rakefile)
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = "lib"
  s.bindir       = "bin"
  s.executables  = %w(bosh_occi_console)

  # TODO Need an OCCI ruby client, GWDG possibly
  # s.add_dependency "occi", ">=0.1"
  s.add_dependency "bosh_common", ">=0.4.0"
  s.add_dependency "bosh_cpi", ">=0.4.2"
  s.add_dependency "httpclient", ">=2.2.0"
  s.add_dependency "uuidtools", ">=2.1.2"
  s.add_dependency "yajl-ruby", ">=0.8.2"
end
