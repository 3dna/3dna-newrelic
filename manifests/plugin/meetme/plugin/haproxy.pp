# == define: newrelic::plugin::meetme::plugin::haproxy
#
# configures the newrelic haproxy plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::haproxy { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::haproxy { 'haproxy1':
#   host     => 'haproxy1',
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
define newrelic::plugin::meetme::plugin::haproxy (
  $host            = 'localhost',
  $port            = 80,
  $path            = '/haproxy?stats',
  $scheme          = 'http',
  $verify_ssl_cert = undef,
  $username        = undef,
  $password        = undef,
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_haproxy"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_haproxy_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.haproxy.erb"),
    order   => "10_application_10_haproxy_${order}",
  }
}
