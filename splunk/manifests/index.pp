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
  $enable   = true,
  $index    = 'default',
  $ensure   = present,
  $basepath = $splunk::users::home
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enable must be true or false")
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
