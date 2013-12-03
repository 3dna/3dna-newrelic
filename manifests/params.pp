# == Class: newrelic::params
#
# default parameters for the newrelic class based on OS and such
#
# not to be called directly
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
  $loglevel = 'info'
  if $::osfamily == 'Debian' {
    $config_file = '/etc/newrelic/nrsysmond.cfg'
    $package     = 'newrelic-sysmond'
    $service     = 'newrelic-sysmond'
    $logfile     = '/var/log/newrelic/nrsysmond.log'
  } else {
    fail("osfamily ${osfamily} not currently supported please make a pull request!")
  }
}
