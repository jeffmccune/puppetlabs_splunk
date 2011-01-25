class { "splunk::users":
  virtual => false
}

class { "splunk::package": }

class { "splunk::service": }

class { "splunk": }
class { "splunk::app": }
class { "splunk::lwf": }
class { "splunk::inputs": }
splunk::inputs::fragment {
  'yum':
    target => '/var/log/yum.log',
}
class { "splunk::outputs": }
class { "splunk::lwf": }
