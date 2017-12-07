require 'puppetlabs_spec_helper/rake_tasks'

## We only need the puppetlabs_spec_helper for other tasks to depend on. Clear all known tasks we are not using.
%w[
  beaker beaker:sets beaker:ssh
  build clean
  compute_dev_version
  parallel_spec spec spec_clean spec_prep spec_standalone
  release_checks check:dot_underscore check:git_ignore check:symlinks check:test_file
].each do |t|
  Rake::Task[t].clear
end
