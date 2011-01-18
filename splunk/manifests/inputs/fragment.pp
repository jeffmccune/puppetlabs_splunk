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
define splunk::inputs::fragment(
  $target,
  $index     = 'default',
  $enable    = true,
  $ensure    = present,
  $port      = '',
  $receiver  = false,
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

  if ($receiver == true and $port == '') {
    fail("must set a port if receiver is set to true")
  }

  if ($target != '' and $receiver == true) {
    fail("you can not set a target and receiver to true")

  if $target {
    file { "${splunk::fragpath}/inputs.d/01_${name}_targetfrag":
       ensure  => $ensure,
       owner   => splunk,
       group   => splunk,
       mode    => '0755',
       content => template('splunk/targetfrag.erb'),
    }
  }

  if $receiver {
    file { "${splunk::fragpath}/inputs.d/02_${name}_receiverfrag":
       ensure  => $ensure,
       owner   => splunk,
       group   => splunk,
       mode    => '0755',
       content => template('splunk/receiverfrag.erb'),
    }
  }
}
