require 'puppet-lint'

# workaround for https://github.com/rodjek/puppet-lint/issues/355
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = false
  config.ignore_paths = PUPPET_EXCLUDE_PATHS
  config.fix = true
end
Rake::Task['lint'].comment = 'fix (supported) issues'

PuppetLint::RakeTask.new 'lint:no_fix' do |config|
  config.fail_on_warnings = false
  config.ignore_paths = PUPPET_EXCLUDE_PATHS
  config.fix = false
end
Rake::Task['lint:no_fix'].comment = 'Do not execute any automatic fixes'

desc 'Run puppet-lint (for jenkins)'
PuppetLint::RakeTask.new 'jenkins:lint' do |config|
  config.fail_on_warnings = true
  config.log_format = '%{path}:%{line}:%{check}:%{KIND}:%{message}'
  config.ignore_paths = PUPPET_EXCLUDE_PATHS
  config.fix = false
end
Rake::Task['jenkins:lint'].comment = 'No fixing, Fails on warnings'
