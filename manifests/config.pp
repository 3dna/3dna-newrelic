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
  $nr_loglevel    = $newrelic::params::nr_loglevel,
  $logfile        = $newrelic::params::logfile,
  $pidfile        = $newrelic::params::pidfile,
  $proxy          = undef,
  $ssl_ca_bundle  = undef,
  $ssl_ca_path    = undef,
  $collector_host = undef,
  $timeout        = undef,
  $hostname       = $::fqdn,
) inherits newrelic::params {
  file { $newrelic::params::config_file:
    content => template('newrelic/nrsysmond.cfg.erb'),
  }
}
