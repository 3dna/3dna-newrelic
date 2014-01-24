# == define: newrelic::plugin::meetme::plugin::rabbitmq
#
# configures the newrelic rabbitmq plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::rabbitmq { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::rabbitmq { 'rabbitmq1':
#   host     => 'rabbitmq1',
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
define newrelic::plugin::meetme::plugin::rabbitmq (
  $host           = 'localhost',
  $port           = 15672,
  $username = undef,
  $password = undef,
  $verify_ssl_cert            = undef,
  $api_path   = '/api',
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  $verify_ssl_cert_bool = str2bool($verify_ssl_cert)

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_rabbitmq"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_rabbitmq_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.rabbitmq.erb"),
    order   => "10_application_10_rabbitmq_${order}",
  }
}
