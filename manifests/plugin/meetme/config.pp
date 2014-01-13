# == Class: newrelic::plugin::meetme::config
#
# configures the meetme plugin
#
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# include newrelic::plugin::meetme::config
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
class newrelic::plugin::meetme::config (
  $newrelic_license_key = $newrelic::config::license_key,
  $wake_interval        = 60,
  # defaults for these come from hiera
  $config_file,
) {
  include newrelic::config

  # does this get variables frem this scope, too?
  datacat { $config_file:
    template => "${module_name}/meetme/newrelic_plugin_agent.cfg.erb",
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
  }
}
