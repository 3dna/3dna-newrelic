# == define: newrelic::plugin::meetme::plugin::apache_httpd
#
# configures the newrelic apache_httpd plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::apache_httpd { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::apache_httpd { 'apache1':
#   host     => 'apache1',
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
define newrelic::plugin::meetme::plugin::apache_httpd (
  $host            = 'localhost',
  $port            = 80,
  $path            = '/server-status',
  $scheme          = 'http',
  $verify_ssl_cert = undef,
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_apache_httpd"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_apache_httpd_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.apache_httpd.erb"),
    order   => "10_application_10_apache_httpd_${order}",
  }
}
