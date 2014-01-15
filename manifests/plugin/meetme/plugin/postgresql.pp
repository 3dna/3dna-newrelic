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
  $host           = 'localhost',
  $port           = 5432,
  $dbname         = 'postgres',
  $user           = 'postgres',
  $password       = undef,
  $superuser      = true,
  $relation_stats = true,
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  # this will need to be factored out for pgbouncer
  # this being here is due to https://github.com/MeetMe/newrelic-plugin-agent/issues/215
  # dependencies taken from https://github.com/MeetMe/newrelic-plugin-agent/blob/master/setup.py#L72
  include postgresql::lib::devel
  package { 'psycopg2':
    provider => 'pip',
    require  => Class['postgresql::lib::devel'],
  }

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_postgresql"])

  $superuser_bool = str2bool($superuser)
  $relation_stats_bool = str2bool($relation_stats)

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_postgresql_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.postgresql.erb"),
    order   => "10_application_10_postgresql_${order}",
  }
}
