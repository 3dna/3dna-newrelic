# == Class: newrelic::plugin::meetme::service
#
# sets up and manages the meetme agent service
#
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# include newrelic::plugin::meetme::service
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
class newrelic::plugin::meetme::service (
  $ensure = undef,
  $enable = true,
  # defaults for these come from hiera
  $service
) {
  service { $service:
    ensure => $ensure,
    enable => $enable,
  }
}
