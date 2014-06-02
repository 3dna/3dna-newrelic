# == Class: newrelic::params
#
# os-specific defaults
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class newrelic::params {
  $service     = 'newrelic-sysmond'
  $package     = 'newrelic-sysmond'
  $logfile     = '/var/log/newrelic/nrsysmond.log'
  $config_file = '/etc/newrelic/nrsysmond.log'
}
