# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{factory_girl_extensions}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["remi"]
  s.date = %q{2009-05-16}
  s.description = %q{helpful extensions for factory_girl}
  s.email = %q{remi@remitaylor.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "lib/factory_girl_extensions.rb",
     "spec/dog_spec.rb",
     "spec/extensions_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/remi/factory_girl_extensions}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{helpful extensions for factory_girl}
  s.test_files = [
    "spec/dog_spec.rb",
     "spec/extensions_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<factory_girl>, [">= 0"])
    else
      s.add_dependency(%q<factory_girl>, [">= 0"])
    end
  else
    s.add_dependency(%q<factory_girl>, [">= 0"])
  end
end
