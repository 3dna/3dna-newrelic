# == Class: newrelic::service
#
# manages the newrelic service as part of the newrelic module. should not be included directly
#
# === Parameters
#
# [*service*]
#   override the default service name from newrelic::params
# [*ensure*]
#   whether or not puppet should ensure the service. defaults to undef
# [*enable*]
#   whether or not the service is enabled to start. defaults to true
#
# === Variables
#
# None
#
# === Examples
#
# include newrelic
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class newrelic::service (
  $service = $newrelic::params::service,
  $ensure  = undef,
  $enable  = true,
) inherits newrelic::params {
  service { $service:
    ensure => $ensure,
    enable => $enable,
  }
}
