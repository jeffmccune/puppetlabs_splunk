# Define: splunk::inputs
#
#   Creates entries in inputs.conf under the puppet
#   Splunk app.  inputs.conf controls the files that
#   are indexed or if the Splunk instance is a
#   receiver of Splunk forwarders.
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
define splunk::inputs(
  $target,
  $index     = 'default',
  $enable    = true,
  $ensure    = present,
  $basepath  = '/var/lib/puppet/spool',
  $port      = '',
  $receiver  = false,
  $app       = ''
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
    file { "${basepath}/splunk/${app}/00_${name}_targetfrag":
       ensure  => $ensure,
       owner   => splunk,
       group   => splunk,
       mode    => '0755',
       content => template('splunk/targetfrag.erb'),
    }
  }

  if $receiver {
    file { "${basepath}/splunk/${app}/00_${name}_receiverfrag":
       ensure  => $ensure,
       owner   => splunk,
       group   => splunk,
       mode    => '0755',
       content => template('splunk/receiverfrag.erb'),
    }
  }
}
