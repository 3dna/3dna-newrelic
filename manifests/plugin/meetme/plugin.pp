# Define: newrelic::plugin::meetme::plugin
#
# configures a plugin stanza for the meetme config file
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna
#
define newrelic::plugin::meetme::plugin (
  $type,
  $config = {},
) {
  include newrelic::plugin::meetme::config

  datacat_fragment { "newrelic::plugin::meetme::plugin::${name}":
    target        => $newrelic::plugin::meetme::config::config_file,
    data          => {
      'Application' => {
        "${type}"       => $config,
      },
    },
  }
}
