# == Class: newrelic::infra::params
#
# params for the infrastructure agent
#
# === Authors
#
# Jeremy Holland <holland@nationbuilder.com>
#
# === Copyright
#
# Copyright 2016 3dna
#
class newrelic::infra::params {
  $package          = 'newrelic-infra'
  $config_file      = '/etc/newrelic-infra.yml'
  $user             = 'newrelic'
  $service          = 'newrelic-infra'
}
