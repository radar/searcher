# -*- encoding: utf-8 -*-
require File.expand_path("../lib/searcher/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "searcher"
  s.version     = Searcher::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Bigg"]
  s.email       = ["radarlistener@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/searcher"
  s.summary     = "Label-based straight-SQL searcher"
  s.description = "Label-based straight-SQL searcher"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "searcher"

  s.add_development_dependency "bundler", ">= 1.0.0"
  
  s.add_dependency "activerecord", "~> 3.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
