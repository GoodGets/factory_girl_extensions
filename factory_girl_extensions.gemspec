# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{factory_girl_extensions}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["remi"]
  s.date = %q{2009-03-29}
  s.description = %q{helpful extensions for factory_girl}
  s.email = %q{remi@remitaylor.com}
  s.files = ["Rakefile", "VERSION.yml", "README.rdoc", "lib/factory_girl_extensions.rb", "spec/dog_spec.rb", "spec/spec_helper.rb", "spec/extensions_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/remi/factory_girl_extensions}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{helpful extensions for factory_girl}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thoughtbot-factory_girl>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-factory_girl>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-factory_girl>, [">= 0"])
  end
end
