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
  $config_file      = '/etc/newrelic/newrelic_plugin_agent.cfg'
  $user             = 'newrelic'
  $pidfile          = '/var/run/newrelic/newrelic_plugin_agent.pid'
  $logfile          = '/var/log/newrelic/newrelic_plugin_agent.log'
  $init_destination = '/etc/init.d/newrelic_plugin_agent'
  $init_source      = '/opt/newrelic_plugin_agent/newrelic_plugin_agent.deb'
  $service          = 'newrelic_plugin_agent'
}
