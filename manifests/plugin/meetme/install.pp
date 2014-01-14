# == Class: newrelic::plugin::meetme::install
#
# manages the installation of the software
#
# https://github.com/MeetMe/newrelic-plugin-agent
#
# === Examples
#
# include newrelic::plugin::meetme::install
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
class newrelic::plugin::meetme::install (
  # defaults for these parameters come from hiera
  $package,
) {
  package { $package:
    provider => 'pip',
  }
}
