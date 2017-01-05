# == Class: newrelic::infra::service
#
# manages the newrelic infrastructure service as part of the newrelic module. should not be included directly
#
# === Parameters
#
# [*service*]
#   override the default service name from the module's hiera
# [*ensure*]
#   whether or not puppet should ensure the service. defaults to true
# [*enable*]
#   whether or not the service is enabled to start. defaults to true
#
# === Variables
#
# None
#
# === Examples
#
# include newrelic::infra
#
# === Authors
#
# Jeremy Holland <holland@nationbuilder.com>
#
# === Copyright
#
# Copyright 2016 3dna
#
class newrelic::infra::service (
  $ensure  = true,
  $enable  = true,
  $service = $newrelic::infra::params::service,
) inherits newrelic::infra::params {
  service { $service:
    ensure => $ensure,
    enable => $enable,
  }
}
