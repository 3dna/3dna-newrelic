# == Class: newrelic::plugin::meetme
#
# installs and configures the base meetme agent for newrelic
#
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# include newrelic::plugin::meetme
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
class newrelic::plugin::meetme (
) {
  include newrelic::plugin::meetme::install
  include newrelic::plugin::meetme::config
  include newrelic::plugin::meetme::service

  anchor {
    'newrelic::plugin::meetme::begin':
      before => [Class['::newrelic::plugin::meetme::install'],Class['::newrelic::plugin::meetme::config']],
      notify => Class['::newrelic::plugin::meetme::service'];
    'newrelic::plugin::meetme::end':
      require => Class['::newrelic::plugin::meetme::service'];
  }

}
