# Class: splunk
#
#   Puppet Labs Splunk module.
#
#   This module manages and configures Splunk
#
#   Jeff McCune <jeff@puppetlabs.com>
#   Cody Herriges <cody@puppetlabs.com>
#
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class splunk(
  $fragbase = '/var/lib/puppet/spool'
  ) {

  $fragpath = "${fragbase}/splunk.d"

  if ! defined(File[$fragbase]) {
    file { $fragbase:
      ensure => directory,
      mode   => '0700',
      owner  => 'root',
      group  => 'root',
    }
  }

  file {
    [
      "${fragpath}",
      "${fragpath}/inputs.d",
      "${fragpath}/outputs.d",
    ]:
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0700',
      purge   => true,
      recurse => true,
  }

}
