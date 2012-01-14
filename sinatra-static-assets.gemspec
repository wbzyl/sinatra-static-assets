# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sinatra-static-assets"
  s.version     = "1.0.1"
  s.authors     = ["Włodek Bzyl"]
  s.email       = ["matwb@ug.edu.pl"]
  s.homepage    = ""
  s.summary     = %q{A Sinatra extension.}
  s.description = %q{This Sinatra extensions provides following helper methods:
    - image_tag
    - stylesheet_link_tag
    - javascript_script_tag}

  s.add_runtime_dependency 'sinatra', '>= 1.1.0'

  s.add_development_dependency 'rack'
  s.add_development_dependency 'rack-test'

  s.rubyforge_project = "sinatra-static-assets"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]
end
