# Define: splunk::inputs
#
#   Brings together all the file fragments
#   for index targets and receivers into a
#   single inputs.conf in the defined app.
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
class splunk::inputs {
  exec { 'rebuild-inputs':
    command     => "/bin/cat ${splunk::fragpath}/inputs.d/* > ${splunk::app::apppath}/default/inputs.conf",
    refreshonly => true,
    subscribe   => [ File["${splunk::app::apppath}/default"], File["${splunk::fragpath}/inputs.d"], ],
  }
  file { "${splunk::app::apppath}/default/inputs.conf":
    mode    => '0644',
    require => Exec['rebuild-inputs'],
  }
}
