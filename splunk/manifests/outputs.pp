# Define: splunk::outputs
#
#   Brings together all the file fragments
#   for forwarders into a single outputs.conf
#   in the defined app.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2011-1-18
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class splunk::outputs(
  compress    = false,
  loadbalance = false
) {
  exec { 'rebuild-outputs':
    command     => "/bin/cat ${splunk::fragpath}/outputs.d/* > ${splunk::app::apppath}/default/outputs.conf",
    refreshonly => true,
    subscribe   => [ File["${splunk::app::apppath}/default"], File["${splunk::fragpath}/outputs.d"], ],
  }

  file { "${splunk::app::apppath}/default/outputs.conf":
    mode    => '0644',
    require => Exec['rebuild-outputs'],
    owner   => "splunk",
    group   => "splunk",
  }

  file {
    "${splunk::fragpath}/outputs.d/00-header-frag":
      content => template("splunk/outputhead.erb")
      notify  => Exec['rebuild-outputs'],
  }
}
