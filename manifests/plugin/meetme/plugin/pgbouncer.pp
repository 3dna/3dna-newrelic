# == define: newrelic::plugin::meetme::plugin::pgbouncer
#
# configures the newrelic pgbouncer plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::pgbouncer { 'localhost': }
#
# newrelic::plugin::meetme::plugin::pgbouncer { 'postgresql13':
#   host     => 'postgresql13',
#   port     => 8765,
# }
#
# === Authors
#
# Dominic Ferrantelli <dominic@nationbuilder.com>
#
# === Copyright
#
# Copyright 2016 3dna
#
define newrelic::plugin::meetme::plugin::pgbouncer (
  $host           = 'localhost',
  $port           = 6432,
  $dbname         = 'pgbouncer',
  $user           = 'stats',
  $password       = undef,
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  # this will need to be factored out for pgbouncer
  # this being here is due to https://github.com/MeetMe/newrelic-plugin-agent/issues/215
  # dependencies taken from https://github.com/MeetMe/newrelic-plugin-agent/blob/master/setup.py#L72

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_pgbouncer"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_pgbouncer_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.pgbouncer.erb"),
    order   => "10_application_10_pgbouncer_${order}",
  }
}
