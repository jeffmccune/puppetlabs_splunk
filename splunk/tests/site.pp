class { "splunk::users":
  virtual => false
}

class { "splunk::package":
  pkg_base => "http://www.puppetlabs.lan/yum/splunk",
}

class { "splunk": }
class { "splunk::app": }
class { "splunk::inputs": }
splunk::inputs::fragment {
  'messages':
    target => '/var/log/message';
  'boot':
    target => '/var/log/boot.log',
}
splunk::inputs::fragment { '9999':
  receiver => true,
}
