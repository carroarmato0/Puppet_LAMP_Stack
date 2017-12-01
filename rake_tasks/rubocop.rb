require 'rubocop/rake_task'
# see https://github.com/eitoball/rubocop-checkstyle_formatter/pull/11
require 'rubocop/formatter/base_formatter'
require 'rubocop/formatter/checkstyle_formatter'
require 'rubocop-rspec'

Rake::Task['rubocop'].clear
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = RUBY_INCLUDE_PATHS
  task.formatters = %w[fuubar offenses]
  task.fail_on_error = false
  task.options = [
    '--config', '.rubocop.yml',
    '--force-exclusion'
  ]
end

RuboCop::RakeTask.new('jenkins:rubocop') do |task|
  task.patterns = RUBY_INCLUDE_PATHS
  task.options = [
    '--format', 'RuboCop::Formatter::CheckstyleFormatter', '--no-color', '--out', 'tmp/ruby-checkstyle.xml',
    '--format', 'clang',
    '--format', 'offenses',
    '--config', '.rubocop.yml',
    '--force-exclusion'
  ]
  task.fail_on_error = false
end
Rake::Task['jenkins:rubocop'].comment = 'No autocorrect / report to (checkstyle) xml'

# Remove the auto correct task for jenkins. Not something we want to automate.
Rake::Task['jenkins:rubocop:auto_correct'].clear
