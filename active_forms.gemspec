# -*- encoding: utf-8 -*-
require File.expand_path('../lib/active_forms/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Micha\xC5\x82 Szajbe"]
  gem.email         = ["michal.szajbe@gmail.com"]
  gem.summary       = %q{Active Forms API wrapper}
  gem.homepage      = "http://github.com/monterail/active_forms"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "active_forms"
  gem.require_paths = ["lib"]
  gem.version       = ActiveForms::VERSION

  gem.add_runtime_dependency "activesupport", ">= 0"
  gem.add_runtime_dependency "httparty", ">= 0.5.2"
  gem.add_development_dependency "thoughtbot-shoulda", ">= 2.10.2"
  gem.add_development_dependency "fakeweb", ">= 1.2.8"
end
