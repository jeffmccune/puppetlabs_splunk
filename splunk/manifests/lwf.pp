# Define: splunk::lwf
#
#   Turns on the Splunk included Light Weight
#   Forwarder application.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2011-1-25
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class splunk::lwf(
  $enable    = true,
  $basepath  = $splunk::users::home
  ) {

  if ! ($enable == true or $enable == false) {
    fail("enable must be true or false")
  }

  file { "lwf_local":
      path   => "${basepath}/etc/apps/SplunkLightForwarder/local",
      ensure => directory,
      owner  => "splunk",
      group  => "splunk",
      mode   => "0755",
      require => Package["splunk"],
  }

  file { "lwf_appconf":
      path => "${basepath}/etc/apps/SplunkLightForwarder/local/app.conf",
      content => template("splunk/lwfappconf.erb"),
      owner  => "splunk",
      group  => "splunk",
      mode   => "0644",
  }
}
