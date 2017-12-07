require_relative 'support'
require 'puppet-strings'

PUPPET_INCLUDE_DOCUMENTATION_EXPANDS ||= PuppetStrings::DEFAULT_SEARCH_PATTERNS.map { |s| "%s/**/#{s}" }.freeze

desc 'Generate Puppet documentation with YARD excluding upstream modules'
task :documentation do |_t|
  exclude_args = PUPPET_EXCLUDE_DOCUMENTATION.map { |x| ['--exclude', x] }.flatten
  include_args = PUPPET_INCLUDE_DOCUMENTATION.product(PUPPET_INCLUDE_DOCUMENTATION_EXPANDS).collect do |incl, expand|
    format(expand, incl)
  end
  PuppetStrings.generate(include_args, yard_args: exclude_args)
end

desc 'Generate Puppet documentation with YARD including upstream modules'
task 'documentation:all' do |_t|
  exclude_args = PUPPET_EXCLUDE_DOCUMENTATION.map { |x| ['--exclude', x] }.flatten
  include_args = %w[site modules].product(PUPPET_INCLUDE_DOCUMENTATION_EXPANDS).collect do |incl, expand|
    format(expand, incl)
  end
  PuppetStrings.generate(include_args, yard_args: exclude_args)
end
