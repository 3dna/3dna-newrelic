# == Class: newrelic::infra::config
#
# configures the infrastructure agent
#
# === Examples
#
# include newrelic::infra::config
#
# === Authors
#
# Jeremy Holland <holland@nationbuilder.com>
#
# === Copyright
#
# Copyright 2016 3dna
#
class newrelic::infra::config (
  $license_key = $newrelic::config::license_key,
) inherits newrelic::infra::params {
  file { $config_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/infra/newrelic-infra.yml.erb"),
  }
}
