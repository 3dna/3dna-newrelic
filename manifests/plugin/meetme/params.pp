# == Class: newrelic::plugin::meetme::params
#
# os specific defaults
#
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
class newrelic::plugin::meetme::params {
  $package          = 'newrelic-plugin-agent'
  $config_file      = '/etc/newrelic/newrelic-plugin-agent.cfg'
  $user             = 'newrelic'
  $pidfile          = '/var/run/newrelic/newrelic-plugin-agent.pid'
  $logfile          = '/var/log/newrelic/newrelic-plugin-agent.log'
  $init_destination = '/etc/init.d/newrelic-plugin-agent'
  $init_source      = '/opt/newrelic-plugin-agent/newrelic-plugin-agent.deb'
  $service          = 'newrelic-plugin-agent'
}
