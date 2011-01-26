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

  splunk::fragment { "00_header":
		content   => "# This file is managed by puppet and will be overwritten\n",
		config_id => "inputs",
		app_id    => "puppet_managed",
  }

  file { "${splunk::app::apppath}/default/inputs.conf":
    mode    => '0644',
    owner   => "splunk",
    group   => "splunk",
    require => File["${splunk::fragpath}/puppet_managed/inputs"],
    notify  => Service["splunk"],
	}

}
