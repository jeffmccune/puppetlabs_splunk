# Define: splunk::outputs
#
#   Generates output entries in outputs.conf
#   which enables the forwarding of information
#   from one machine to another.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2010-1-11
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define splunk::outputs::fragment(
  $target,
  $enable    = true,
  $ensure    = present,
  $basepath  = $splunk::users::home,
  $port      = '',
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

  if ! ($receiver == true or $receiver == false) {
    fail("receiver must be true or false")
  }

  if (($receiver == true or $forwarder == true) and $port == '') {
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

  file { "${basepath}/etc/apps/puppet_${name}/default/app.conf":
      ensure => $ensure,
      owner  => splunk,
      group  => splunk,
      mode   => '0755',
      content => template('splunk/appconf.erb'),
  }
  file { "${basepath}/etc/apps/puppet_${name}/default/inputs.conf":
     ensure => $ensure,
     owner  => splunk,
     group  => splunk,
     mode   => '0755',
     content => template('splunk/inputsconf.erb'),
  }

  if $forwarder {
    file { "${basepath}/etc/apps/puppet_${name}/default/outputs.conf":
      ensure => $ensure,
      owner  => splunk,
      group  => splunk,
      mode   => '0755',
      content => template('splunk/outputsconf.erb'),
    }
  }

}
