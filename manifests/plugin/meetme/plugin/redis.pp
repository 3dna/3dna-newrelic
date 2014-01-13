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
  $db_count = 16,
  $password = undef,
  $path     = undef,
) {
  include newrelic::plugin::meetme
  include newrelic::plugin::meetme::config

  newrelic::plugin::meetme::plugin { "redis_${name}":
    type    => 'redis',
    config  => [
      {
        name     => $name,
        host     => $host ,
        db_count => $db_count,
        password => $password,
        path     => $path,
      },
    ],
  }
}
