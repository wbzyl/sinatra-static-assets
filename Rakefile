require 'rake'
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sinatra-static-assets"
    gemspec.summary = "Sinatra extension providing helper methods to output tags for static assetgemspec."
    gemspec.email = "matwb@univ.gda.pl"
    gemspec.homepage = "http://github.com/wbzyl/sinatra-static-assets"
    gemspec.authors = ["Wlodek Bzyl"]
    
    gemspec.description = <<-EOF
This Sinatra extensions provides following helper methods:
  - image_tag
  - stylesheet_link_tag
  - javascript_script_tag
    EOF
    
    gemspec.files = %w{TODO VERSION.yml} + FileList['lib/**/*.rb', 'test/**/*.rb', 'examples/**/*']
    
    gemspec.add_runtime_dependency 'rack', '>=1.0.0'
    gemspec.add_runtime_dependency 'sinatra', '>=0.9.1'
    gemspec.add_runtime_dependency 'emk-sinatra-url-for', '>=0.2.1'      

    gemspec.add_development_dependency 'rack-test', '>=0.3.0'

    gemspec.rubyforge_project = 'sinatra-static-assets'
  end
rescue LoadError
  puts "Jeweler not available."
  puts "Install it with:"
  puts "  sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end
