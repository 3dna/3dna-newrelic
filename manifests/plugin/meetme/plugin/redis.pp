# == define: newrelic::plugin::meetme::plugin::redis
#
# configures the newrelic redis plugin from meetme
#
# http://newrelic.com/plugins/meetme-inc/28
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# newrelic::plugin::meetme::plugin::redis { 'localhost': }
# 
# newrelic::plugin::meetme::plugin::redis { 'redis1':
#   host     => 'redis1',
#   port     => 8765,
#   password => 'foo',
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
define newrelic::plugin::meetme::plugin::redis (
  $host     = 'localhost',
  $port     = 6379,
  $db_count = 16, # needs to be an integer
  $password = undef, # should not be sent at all if it's undef
  $path     = undef, # should not be sent at all if it's undef
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config
  include newrelic::plugin::meetme::plugin::redishead

  $config_file = $newrelic::plugin::meetme::config
  $order = fqdn_rand(100)
  concat::fragment { "${config_file}_application_redis_${name}":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.redis.erb"),
    order   => "10_application_10_redis_${order}",
  }
}
