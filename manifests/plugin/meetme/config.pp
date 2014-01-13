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
  $wake_interval        = 60,
  $proxy                = undef,
  # defaults for these come from hiera
  $config_file,
  $init_destination,
  $init_source,
  $user,
  $pidfile,
  $logfile,
) {
  include newrelic::config

  datacat { $config_file:
    template_body => '<%= @data.to_yaml %>',
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
  }

  datacat_fragment { "${config_file}_application":
    target            => $config_file,
    data              => {
      'Application'    => {
        license_key   => $newrelic_license_key,
        wake_interval => $wake_interval,
      },
      'Daemon'    => {
        user    => $user,
        pidfile => $pidfile,
      }
    }
  }

  if ($proxy) {
    datacat_fragment { "${config_file}_application_proxy":
      target        => $config_file,
      data          => {
        'Application' => {
          proxy     => $proxy,
        },
      },
    }
  }

  # hardcoded logging for now, this is all taken directly from the default config file
  # each of these segments should probably be converted to a resource and then there's a flag for
  # default_logging_configuration which uses these resources to build this section
  datacat_fragment { "${config_file}_logging":
    target         => $config_file,
    data           => {
      'Logging'      => {
        formatters => {
          verbose  => {
            format => '%(levelname) -10s %(asctime)s %(process)-6d %(processName) -15s %(threadName)-10s %(name) -45s %(funcName) -25s L%(lineno)-6d: %(message)s',
          },
        },
        handlers        => {
          file          => {
            'class'       => 'logging.handlers.RotatingFileHandler',
            formatter   => 'verbose',
            filename    => $logfile,
            maxBytes    => 10485760,
            backupCount => 3,
          },
        },
        loggers                   => {
          'newrelic_plugin-agent' => {
            level                 => 'INFO',
            propagate             => true,
            handlers              => [ 'console','file' ],
          },
          requests    => {
            level     => 'ERROR',
            propagate => true,
            handlers  => [ 'console','file' ],
          },
        },
      },
    },
  }

  # install the init script in the proper place
  file { $init_destination:
    ensure => $init_source,
  }
}
