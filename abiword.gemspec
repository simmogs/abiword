#require 'rubygems'
#require 'rake/packagetask'
#require 'rake/gempackagetask'
$:.push File.expand_path("../lib", __FILE__)
require "abiword/version"

spec = Gem::Specification.new do |s|
  s.name = "abiword"
  s.version = Abiword::VERSION
  s.authors = ["Puneet Paul"]
  s.email = "puneetpaul74@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.description = "Ruby wrapper for abiword"
  s.summary = "Provides binaries for abiword only to convert word doc and docx documents to pdf"
  s.files =  ["lib/abiword.rb"]
  s.test_files = [Dir.glob('test/test*.rb'),Dir.glob('testfiles/*')].flatten
  s.has_rdoc = false
  s.require_path = ["lib"]
  s.homepage = 'http://rubygems.org/gems/abiword'

  s.add_runtime_dependency 'mimemagic'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-test'
  s.add_development_dependency 'test-unit'
end
