# Class: splunk
#
#   Puppet Labs Splunk module.
#
#   This module manages and configures Splunk
#
#   Jeff McCune <jeff@puppetlabs.com>
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
  $indexer     = false,
  $forwarder   = false,
  $search_head = false,
  $software    = true
  ) {
  # statements
  class { "splunk::users": }
  if ($package) {
    class { "${module_name}::package": }
  }
}
