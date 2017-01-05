# == Class: newrelic::infra
#
# installs and configures the newrelic infra server monitoring agent
#
# === Parameters
#
# === Examples
#
#  class { newrelic::infra: }
#
# === Authors
#
# Jeremy Holland <holland@nationbuilder.com>
#
# === Copyright
#
# Copyright 2016 3dna
#
class newrelic::infra {
  include ::newrelic::infra::install
  include ::newrelic::infra::config
  include ::newrelic::infra::service

  Class['::newrelic::infra::install'] -> Class['::newrelic::infra::config'] ~> Class['::newrelic::infra::service']

  anchor {
    'newrelic::infra::begin':
      before => [Class['::newrelic::infra::install'],Class['::newrelic::infra::config']],
      notify => Class['::newrelic::infra::service'];
    'newrelic::infra::end':
      nrequire => Class['::newrelic::infra::service'];
  }
}
