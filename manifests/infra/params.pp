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
  $config_file      = '/etc/newrelic/newrelic-infra.yml'
  $user             = 'newrelic'
  $pidfile          = '/var/run/newrelic/newrelic-infra-agent.pid'
  $logfile          = '/var/log/newrelic/newrelic-infra-agent.log'
  $init_destination = '/etc/init.d/newrelic-infra-agent'
  $init_source      = '/opt/newrelic-infra-agent/newrelic-infra-agent.deb'
  $service          = 'newrelic-infra-agent'
}
