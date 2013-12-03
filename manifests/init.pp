# == Class: newrelic
#
# installs and configures the newrelic server monitoring agent
#
# === Parameters
#
# === Examples
#
#  class { newrelic: }
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class newrelic inherits newrelic::params {
  include ::newrelic::install
  include ::newrelic::config
  include ::newrelic::service

  Class["::newrelic::install"] -> Class["::newrelic::config"] ~> Class["::newrelic::service"]

  anchor {
    'newrelic::begin':
      before => [Class['::newrelic::install'],Class['::newrelic::config']],
      notify => Class['::newrelic::service'];
    'newrelic::end':
      require => Class['::newrelic::service'];
  }
}
