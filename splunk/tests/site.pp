class { "splunk::users":
  virtual => false
}
class { "splunk::package":
	pkg_base => "http://www.puppetlabs.lan/yum/splunk",
}

