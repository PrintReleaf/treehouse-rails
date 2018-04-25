$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "treehouse/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "treehouse-rails"
  s.version     = Treehouse::VERSION
  s.authors     = ["PrintReleaf"]
  s.email       = ["tech@printreleaf.com"]
  s.homepage    = "https://github.com/printreleaf/treehouse-rails"
  s.summary     = "treehouse-rails"
  s.description = "Treehouse authentication middleware for Rails"
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2"
  s.add_development_dependency "rspec-rails", ">= 3.3.3"
end

