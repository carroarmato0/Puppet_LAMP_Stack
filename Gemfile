source 'https://rubygems.org'

def location_from_env(env, default_location = [])
  if ENV[env]
    location = ENV[env]
    if location =~ %r{^(?<git_location>(?:git|https?)[:@][^#]*)#(?<git_branch>.*)}
      [{ git: git_location, branch: git_branch, require: false }]
    elsif location =~ %r{^file://(?<filename>.*)}
      ['>= 0', { path: File.expand_path(filename), require: false }]
    else
      [location, { require: false }]
    end
  else
    default_location
  end
end

gem 'puppet', *location_from_env('PUPPET_GEM_VERSION')

group :eyaml do
  gem 'gpgme'
  gem 'hiera-eyaml'
  gem 'hiera-eyaml-gpg'
end

group :development do
  gem 'awesome_print'
end

group :test do
  gem 'puppet-lint', '!= 2.3.2'
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
  gem 'puppet-lint-file_ensure-check'
  # gem 'puppet-lint-global_resource-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-param-docs', '>= 1.4.0'
  # gem 'puppet-lint-resource_outside_class-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-variable_contains_upcase'
  gem 'puppet-lint-version_comparison-check'
  # gem 'puppet-lint-package_ensure-check'
  # gem 'puppet-lint-numericvariable'
  gem 'json_pure', '<=2.0.1', require: false if RUBY_VERSION =~ %r{^1\.}
  gem 'puppet-syntax'
  gem 'puppet_rake_tasks', '~> 1.0.0'
  gem 'puppetlabs_spec_helper'
  gem 'rspec'
  gem 'rubocop', '~> 0.48.1'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rspec'
end

group :doc do
  gem 'puppet-strings', '~> 1.0.0'
  gem 'rdoc'
  gem 'redcarpet'
end
