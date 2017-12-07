require 'puppet_rake_tasks/depchecker'

PuppetRakeTasks::DepChecker::Task.new do |checker|
  checker.fail_on_error = true
  checker.modulepath = [
    'site',
    'modules/vrt',
    'modules/upstream'
  ]
  checker.ignores = YAML.load_file(PUPPET_DEPENDENCY_CONFIG) if PUPPET_DEPENDENCY_CONFIG
end
