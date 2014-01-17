# == define: newrelic::plugin::meetme::plugin::mongodb
#
# configures the newrelic mongodb plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::mongodb { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::mongodb { 'mongodb1':
#   host     => 'mongodb1',
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
define newrelic::plugin::meetme::plugin::mongodb (
  $host           = 'localhost',
  $port           = 27017,
  $admin_username = undef,
  $admin_password = undef,
  $ssl            = undef,
  $ssl_keyfile    = undef,
  $ssl_certfile   = undef,
  $ssl_cert_reqs  = undef,
  $ssl_ca_certs   = undef,
  $databases      = {},
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  # this being here is due to https://github.com/MeetMe/newrelic-plugin-agent/issues/215
  # dependencies taken from https://github.com/MeetMe/newrelic-plugin-agent/blob/master/setup.py#L72
  package { 'pymongo':
    provider => 'pip',
  }

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_mongodb"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_mongodb_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.mongodb.erb"),
    order   => "10_application_10_mongodb_${order}",
  }
}
