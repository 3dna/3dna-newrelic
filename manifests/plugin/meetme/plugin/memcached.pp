# == define: newrelic::plugin::meetme::plugin::memcached
#
# configures the newrelic memcached plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::memcached { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::memcached { 'memcached1':
#   host     => 'memcached1',
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
define newrelic::plugin::meetme::plugin::memcached (
  $host     = 'localhost',
  $port     = 11211,
  $path     = undef, # should not be sent at all if it's undef
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  $config_file = $newrelic::plugin::meetme::config::config_file
  realize(Concat::Fragment["${config_file}_application_memcached"])

  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_memcached_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.memcached.erb"),
    order   => "10_application_10_memcached_${order}",
  }
}
