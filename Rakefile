# Rakefile
require 'rubygems'
require_relative 'rake_tasks/support'

PUPPET_INCLUDE_DOCUMENTATION = %w[
  modules
  manifests
].freeze

# Leave this commented to use the default puppetstrings patterns with some
# magic sprinkled on top (see rake_tasks/documentation.rb)
# PUPPET_INCLUDE_DOCUMENTATION_EXPANDS = [
#   '%s/**/manifests/**/*.pp',
#   '%s/**/lib/**/*.rb'
# ].freeze

PUPPET_EXCLUDE_DOCUMENTATION = [
  '/vendor/',
  '/spec/'
].freeze

PUPPET_EXCLUDE_PATHS = [
  # 'modules/upstream/**/*',
  # 'modules/<company>/**/*',
  'vendor/**/*',
  '**/vendor/**/*',
  '**/spec/**/*'
].freeze

PUPPET_DEPENDENCY_CONFIG = File.join(File.dirname(__FILE__), '.puppet_dependency_ignores.yaml')

HIERA_INCLUDE_PATHS = [
  'hieradata/**/*.yaml'
].freeze

RUBY_INCLUDE_PATHS = [
  'Rakefile',
  'Gemfile',
  'rake_tasks/*.rb',
  # Add more 'module' paths wich contain ruby here
].freeze

JENKINS_TASKS = [
  'syntax',
  'jenkins:lint',
  'jenkins:rubocop',
  'documentation'
].freeze

require_relative 'rake_tasks/spec' # required for puppet-syntax and puppet-lint
require_relative 'rake_tasks/puppet_syntax'
require_relative 'rake_tasks/rubocop'
require_relative 'rake_tasks/puppet_lint'
require_relative 'rake_tasks/documentation'
require_relative 'rake_tasks/jenkins'
require_relative 'rake_tasks/module_depcheck'

Rake::Task['default'].clear
DEFAULT_TASKS = %i[syntax lint rubocop depcheck].freeze
desc "Runs default task (#{DEFAULT_TASKS.join(', ')})"
task default: DEFAULT_TASKS
