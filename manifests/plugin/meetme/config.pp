# == Class: newrelic::plugin::meetme::config
#
# configures the meetme plugin
#
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# include newrelic::plugin::meetme::config
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
class newrelic::plugin::meetme::config (
  $newrelic_license_key = $newrelic::config::license_key,
  $proxy                = undef,
  $newrelic_api_timeout = undef,
  $config_file          = $newrelic::plugin::meetme::params::config_file,
  $init_destination     = $newrelic::plugin::meetme::params::init_destination,
  $init_source          = $newrelic::plugin::meetme::params::init_source,
  $user                 = $newrelic::plugin::meetme::params::user,
  $pidfile              = $newrelic::plugin::meetme::params::pidfile,
  $logfile              = $newrelic::plugin::meetme::params::logfile,
  $wake_interval        = 60, # needs to be an integer
) inherits newrelic::plugin::meetme::params {
  include newrelic::config

  concat { $config_file:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment { "${config_file}_head":
    target  => $config_file,
    content => "%YAML 1.2\n---\n",
    order   => '00',
  }

  concat::fragment { "${config_file}_application_head":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.application_head.erb"),
    order   => "10_application_00",
  }

  # virtual so we can realize() them inside the plugin modules, similar to include but without having to make a class for each
  @concat::fragment { "${config_file}_application_redis":
    target  => $config_file,
    content => "  redis:\n",
    order   => "10_application_10_redis_000",
  }

  @concat::fragment { "${config_file}_application_memcached":
    target  => $config_file,
    content => "  memcached:\n",
    order   => "10_application_10_memcached_000",
  }

  @concat::fragment { "${config_file}_application_haproxy":
    target  => $config_file,
    content => "  haproxy:\n",
    order   => "10_application_10_haproxy_000",
  }

  @concat::fragment { "${config_file}_application_apache_httpd":
    target  => $config_file,
    content => "  apache_httpd:\n",
    order   => "10_application_10_apache_httpd_000",
  }

  @concat::fragment { "${config_file}_application_postgresql":
    target  => $config_file,
    content => "  postgresql:\n",
    order   => '10_application_10_postgresql_000',
  }

  @concat::fragment { "${config_file}_application_mongodb":
    target  => $config_file,
    content => "  mongodb:\n",
    order   => '10_application_10_mongodb_000',
  }

  @concat::fragment { "${config_file}_application_rabbitmq":
    target  => $config_file,
    content => "  rabbitmq:\n",
    order   => '10_application_10_rabbitmq_000',
  }

  concat::fragment { "${config_file}_tail":
    target  => $config_file,
    content => template("${module_name}/meetme/newrelic_plugin_agent.cfg.tail.erb"),
    order   => "99",
  }

  # install the init script in the proper place
  file {
    $init_destination:
      ensure     => $init_source;
    $init_source:
      mode => '0755';
  }
}
