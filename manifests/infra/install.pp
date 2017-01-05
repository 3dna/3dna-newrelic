# == Class: newrelic::infra::install
#
# installs the infrastructure agent
#
# === Examples
#
# include newrelic::infra::install
#
# === Authors
#
# Jeremy Holland <holland@nationbuilder.com>
#
# === Copyright
#
# Copyright 2016 3dna
#
class newrelic::infra::install (
  $package = $newrelic::infra::params::package,
) inherits newrelic::infra::params {
  # probably should be a separate class
  apt::source { 'newrelic-infra':
    location    => 'http://download.newrelic.com/infrastructure_agent/linux/apt',
    release     => 'trusty',
    repos       => 'main',
    include_src => false,
    key         => '8ECCE87C',
    key_source  => 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg',
  }

  package {$package:
    ensure  => installed,
    require => Apt::Source['newrelic-infra'],
  }
}
