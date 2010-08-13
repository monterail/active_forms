# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_forms}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Micha\305\202 Szajbe"]
  s.date = %q{2010-08-13}
  s.email = %q{michal.szajbe@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "active_forms.gemspec",
     "lib/active_forms.rb",
     "lib/active_forms/application.rb",
     "lib/active_forms/application_print.rb",
     "lib/active_forms/configuration.rb",
     "lib/active_forms/form.rb",
     "lib/active_forms/mapper.rb",
     "lib/active_forms/request.rb",
     "test/active_forms/application_print_test.rb",
     "test/active_forms/application_test.rb",
     "test/active_forms/form_test.rb",
     "test/active_forms/mapper_test.rb",
     "test/active_forms/request_test.rb",
     "test/active_forms_test.rb",
     "test/fixtures/error.xml",
     "test/fixtures/get_applicationdata.xml",
     "test/fixtures/get_applicationprint.xml",
     "test/fixtures/get_applications.xml",
     "test/fixtures/get_applications_single.xml",
     "test/fixtures/get_forms.xml",
     "test/fixtures/get_forms_single.xml",
     "test/fixtures/success.xml",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/monterail/active_forms}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Active Forms API wrapper}
  s.test_files = [
    "test/active_forms/application_print_test.rb",
     "test/active_forms/application_test.rb",
     "test/active_forms/form_test.rb",
     "test/active_forms/mapper_test.rb",
     "test/active_forms/request_test.rb",
     "test/active_forms_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.5.2"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 2.10.2"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.8"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0.5.2"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 2.10.2"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0.5.2"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 2.10.2"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
  end
end

