require 'puppet-syntax/tasks/puppet-syntax'

PuppetSyntax.future_parser = true unless Puppet::PUPPETVERSION.to_i >= 4

PuppetSyntax.hieradata_paths = HIERA_INCLUDE_PATHS
PuppetSyntax.exclude_paths = PUPPET_EXCLUDE_PATHS
