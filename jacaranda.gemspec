# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jacaranda/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mauro George"]
  gem.email         = ["maurogot@gmail.com"]
  gem.description   = %q{jacaranda generates helper methods based on your model validations.}
  gem.summary       = %q{jacaranda generates helper methods based on your model validations -
                          creating common methods and scopes.}
  gem.homepage      = "https://github.com/maurogeorge/jacaranda"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jacaranda"
  gem.require_paths = ["lib"]
  gem.version       = Jacaranda::VERSION

  gem.add_dependency "activerecord", ">= 3.0.0"

  gem.post_install_message = 'Jacaranda is deprecated. More info at http://groselhas.maurogeorge.com.br/good-bye-jacaranda-and-welcome-activerecord-enum.html'

  gem.add_development_dependency "rake"
  gem.add_development_dependency "coveralls"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry-meta"
end
