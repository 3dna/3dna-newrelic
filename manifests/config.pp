# == Class: newrelic::config
#
# installs the newrelic config file. meant to be used by the newrelic clas
#
# === Examples
#
# in manifest:
# include newrelic
#
# in hiera:
# ---
# newrelic::config::license_key: ABC123
# newrelic::config::nr_loglevel: info
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class newrelic::config (
  $license_key,
  $proxy          = undef,
  $ssl_ca_bundle  = undef,
  $ssl_ca_path    = undef,
  $collector_host = undef,
  $timeout        = undef,
  $hostname       = $::fqdn,
  $pidfile        = undef,
  $nr_loglevel    = 'info',
  $logfile        = $newrelic::params::logfile,
  $config_file    = $newrelic::params::config_file,
) inherits newrelic::params {
  file { $config_file:
    content => template('newrelic/nrsysmond.cfg.erb'),
  }
}
