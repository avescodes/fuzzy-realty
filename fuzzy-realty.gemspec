# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fuzzy-realty}
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Neufeld"]
  s.date = %q{2009-04-29}
  s.email = %q{rkneufeld@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/TODO",
    "lib/benchmark.rb",
    "lib/classes.rb",
    "lib/fuzzy_realty.rb",
    "lib/profiler.rb",
    "lib/rulebase.rb",
    "lib/scores_table.rb",
    "lib/weights.rb",
    "test/fuzzy_realty_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rkneufeld/fuzzy-realty}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Fuzzy search for Expert Systems Real Estate site}
  s.test_files = [
    "test/fuzzy_realty_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
