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
  $enable    = true,
  $ensure    = present,
  $port
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enabled must be present or absent")
  }

  file { "${splunk::fragpath}/outputs.d/01_${name}_outputfrag":
    ensure  => $ensure,
    owner   => splunk,
    group   => splunk,
    mode    => '0644',
    content => template('splunk/outputfrag.erb'),
    notify  => Exec['rebuild-outputs'],
  }
}
