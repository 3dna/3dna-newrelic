# == Class: newrelic::install
#
# install the newrelic package, meant to be used only as part of the 'newrelic' class
#
# === Parameters
#
# [*$package*]
#   the name of the package
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class newrelic::install (
  # these defaults provided via hiera
  $package = $newrelic::params::package,
) inherits newrelic::params {
  # probably should be a separate class
  apt::source { 'newrelic':
    location    => 'http://apt.newrelic.com/debian/',
    release     => 'newrelic',
    repos       => 'non-free',
    include     => {
      'src'       => false,
    },
    key         => {
      'id'        => 'B60A3EC9BC013B9C23790EC8B31B29E5548C16BF',
      'source'    => 'https://download.newrelic.com/548C16BF.gpg',
    },
  }

  package {$package:
    ensure  => installed,
    require => Apt::Source['newrelic'],
  }
}
