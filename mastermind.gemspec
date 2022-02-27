# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'Mastermind'
  s.version     = '1.0.0'
  s.licenses    = ['MIT']
  s.summary     = "A gem to play `Mastermind`!"
  s.description = "Play the class game `Mastermind` in your Terminal!"
  s.authors     = ["Drew Spelman"]
  s.email       = 'drewspelman@gmail.com'
  s.files       = Dir["{bin,lib,spec,helper}/**/*"] + %w(LICENSE README.md)
  s.test_files  = Dir["spec/**/*"]
  s.bindir      = 'bin'
  s.executables = ['Mastermind']
  s.homepage    = 'https://www.thisfoxcodes.com'
  s.metadata    = { "source_code_uri" => "https://github.com/dmspelma/mastermind" }
  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec', '~>2.8', ">=2.8.0"
end