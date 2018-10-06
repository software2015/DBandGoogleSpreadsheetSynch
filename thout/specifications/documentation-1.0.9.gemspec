# -*- encoding: utf-8 -*-
# stub: documentation 1.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "documentation".freeze
  s.version = "1.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Cooke".freeze]
  s.date = "2015-03-05"
  s.description = "It does cool stuff!".freeze
  s.email = ["adam@atechmedia.com".freeze]
  s.homepage = "http://adamcooke.io".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "A Rails engine to provider the ability to add documentation to a Rails application".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, ["< 5.0", ">= 4.0.0"])
      s.add_runtime_dependency(%q<haml>.freeze, ["~> 4.0"])
      s.add_runtime_dependency(%q<dynamic_form>.freeze, [">= 1.1.4", "~> 1.1"])
      s.add_runtime_dependency(%q<jquery-rails>.freeze, ["< 5", ">= 3.0"])
      s.add_runtime_dependency(%q<coffee-rails>.freeze, ["~> 4"])
      s.add_runtime_dependency(%q<sass-rails>.freeze, ["< 6", ">= 4.0"])
      s.add_runtime_dependency(%q<uglifier>.freeze, ["< 3.0", ">= 2.2"])
      s.add_runtime_dependency(%q<redcarpet>.freeze, ["< 4.0", ">= 3.1.0"])
      s.add_runtime_dependency(%q<pygments.rb>.freeze, ["< 1.0", ">= 0.5"])
      s.add_runtime_dependency(%q<nifty-attachments>.freeze, ["< 2", ">= 1.0.3"])
      s.add_runtime_dependency(%q<nifty-dialog>.freeze, ["~> 1"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<rails>.freeze, ["< 5.0", ">= 4.0.0"])
      s.add_dependency(%q<haml>.freeze, ["~> 4.0"])
      s.add_dependency(%q<dynamic_form>.freeze, [">= 1.1.4", "~> 1.1"])
      s.add_dependency(%q<jquery-rails>.freeze, ["< 5", ">= 3.0"])
      s.add_dependency(%q<coffee-rails>.freeze, ["~> 4"])
      s.add_dependency(%q<sass-rails>.freeze, ["< 6", ">= 4.0"])
      s.add_dependency(%q<uglifier>.freeze, ["< 3.0", ">= 2.2"])
      s.add_dependency(%q<redcarpet>.freeze, ["< 4.0", ">= 3.1.0"])
      s.add_dependency(%q<pygments.rb>.freeze, ["< 1.0", ">= 0.5"])
      s.add_dependency(%q<nifty-attachments>.freeze, ["< 2", ">= 1.0.3"])
      s.add_dependency(%q<nifty-dialog>.freeze, ["~> 1"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<rails>.freeze, ["< 5.0", ">= 4.0.0"])
    s.add_dependency(%q<haml>.freeze, ["~> 4.0"])
    s.add_dependency(%q<dynamic_form>.freeze, [">= 1.1.4", "~> 1.1"])
    s.add_dependency(%q<jquery-rails>.freeze, ["< 5", ">= 3.0"])
    s.add_dependency(%q<coffee-rails>.freeze, ["~> 4"])
    s.add_dependency(%q<sass-rails>.freeze, ["< 6", ">= 4.0"])
    s.add_dependency(%q<uglifier>.freeze, ["< 3.0", ">= 2.2"])
    s.add_dependency(%q<redcarpet>.freeze, ["< 4.0", ">= 3.1.0"])
    s.add_dependency(%q<pygments.rb>.freeze, ["< 1.0", ">= 0.5"])
    s.add_dependency(%q<nifty-attachments>.freeze, ["< 2", ">= 1.0.3"])
    s.add_dependency(%q<nifty-dialog>.freeze, ["~> 1"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
  end
end
