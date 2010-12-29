# Define: splunk::index
#
#   Creates entries for Splunk to index for searching.
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
define splunk::index(
  $target,
  $enable    = true,
  $index     = 'default',
  $ensure    = present,
  $basepath  = $splunk::users::home
  $forwarder = 'false',
  $port      = '',
  $receiver  = 'false'
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enable must be true or false")
  }

  if ! ($forwarder == true or $forwarder == false) {
    fail("forwarder must be true or false")
  }

  if ! ($receiver == true or $reveiver == false) {
    fail("receiver must be true or false")
  }

  if ($receiver == true or $forwarder == true and $port == '') {
    fail("must set a port if receiver or forwarder is set to true")
  }

  file {
    [
      "${basepath}/etc/apps/puppet_${name}",
      "${basepath}/etc/apps/puppet_${name}/default",
    ]:
      ensure => directory,
      owner  => splunk,
      group  => splunk,
      mode   => '0755',
  }

  file {
    "${basepath}/etc/apps/puppet_${name}/default/app.conf":
      ensure => $ensure,
      owner  => splunk,
      group  => splunk,
      mode   => '0755',
      content => template('splunk/appconf.erb');
   "${basepath}/etc/apps/puppet_${name}/default/inputs.conf":
     ensure => $ensure,
     owner  => splunk,
     group  => splunk,
     mode   => '0755',
     content => template('splunk/inputsconf.erb');
  }

}
