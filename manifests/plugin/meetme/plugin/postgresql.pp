# == define: newrelic::plugin::meetme::plugin::postgresql
#
# configures the newrelic postgresql plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::postgresql { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::postgresql { 'postgresql13':
#   host     => 'postgresql13',
#   port     => 8765,
# }
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
define newrelic::plugin::meetme::plugin::postgresql (
  $host      = 'localhost',
  $port      = 5432,
  $user      = 'postgres',
  $dbname    = 'postgres',
  $superuser = true,
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_postgresql"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_postgresql_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.postgresql.erb"),
    order   => "10_application_10_postgresql_${order}",
  }
}
