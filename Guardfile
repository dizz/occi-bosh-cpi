# Copyright (c) 2012 Piston Cloud Computing, Inc.
# Copyright (c) 2012 ZHAW

guard :bundler, :notify => false do
  watch("Gemfile")
end

group :unit_tests do
  guard :rspec, :version => 2, :cli => "--color --format nested --fail-fast",
                :all_after_pass => false, :spec_paths => %w(spec/unit) do
    watch("spec/spec_helper.rb")             { "spec/unit" }
    watch("occi.rb")                    { "spec/unit" }
    watch(%r{^spec/unit/.+_spec\.rb})
    watch(%r{^lib/cloud/occi/(.+)\.rb}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  end
end
