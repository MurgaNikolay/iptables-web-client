# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iptables_web/version'
Gem::Specification.new do |spec|
  spec.name          = 'iptables-web'
  spec.version       = IptablesWeb::VERSION
  spec.authors       = ['NikolayMurga']
  spec.email         = ['nikolay.m@randrmusic.com']
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = Dir['{lib,vendor,bin}/**/*'] + %w(LICENSE.txt README.md)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'system-getifaddrs'
  spec.add_runtime_dependency 'rvm'
  spec.add_runtime_dependency 'activeresource'
  spec.add_runtime_dependency 'commander'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end