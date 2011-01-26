# Define: splunk::inputs::fragment
#
#   Creates framents that become entries in
#   inputs.conf as part of the Splunk App
#   created by Puppet. Entries included are
#   files to be indexed or ports that
#   Splunk wil receiver forwarders on.
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

# Split fragment defines into high and low level.

define splunk::inputs::receiver(
  $enable    = true,
  $ensure    = present,
  $port,
  $receiver  = false,
  $app_id     = "puppet_managed"
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enabled must be present or absent")
  }

  if ! ($receiver == true or $receiver == false) {
    fail("receiver must be true or false")
  }

  splunk::fragment { "02_receiverfrag_${name}":
    content     => template('splunk/receiverfrag.erb'),
    fragment_id => "02_recieverfrag_${name}",
    app_id      => $app_id,
    config_id   => "inputs",
  }
}
