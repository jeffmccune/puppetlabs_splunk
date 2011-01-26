# Define: splunk::inputs::fragment
#
#   Creates target framents that become
#   entries in inputs.conf as part of the
#   Splunk App created by Puppet. Entries
#   included are files to be indexed.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2010-12-22
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define splunk::inputs::target(
  $target    = '',
  $index     = 'main',
  $enable    = true,
  $ensure    = present,
) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enabled must be present or absent")
  }

  splunk::fragment { "01_${name}_targetfrag":
    content     => template('splunk/targetfrag.erb'),
    config_file => "inputs",
  }
}
