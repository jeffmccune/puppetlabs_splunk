class { "splunk::users":
  virtual => false
}
class { "splunk::package":
  pkg_base => "http://www.puppetlabs.lan/yum/splunk",
}

splunk::index { 'syslog':
    target => [ '/var/log/dmesg', '/var/log/messages' ],
    require => Class['splunk::package'],
}
