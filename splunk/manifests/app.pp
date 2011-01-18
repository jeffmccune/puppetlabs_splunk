# Define: splunk::app
#
#   Creates the initial app.conf and it's parents directories
#   for the portion of Splunk being managed by Puppet.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2011-1-07
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class splunk::app(
  $enable    = true,
  $ensure    = present,
  $basepath  = $splunk::users::home,
  $appname   = 'puppet_managed'
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enable must be true or false")
  }

  $apppath = "${basepath}/etc/apps/${appname}"

  file {
    [
      "${apppath}",
      "${apppath}/default",
    ]:
      ensure => directory,
      owner  => splunk,
      group  => splunk,
      mode   => '0755',
  }

  file { "${apppath}/default/app.conf":
      ensure => $ensure,
      owner  => splunk,
      group  => splunk,
      mode   => '0755',
      content => template('splunk/appconf.erb'),
  }
}
