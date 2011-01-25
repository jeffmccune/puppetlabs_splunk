class { "splunk::users":
  virtual => false
}

class { "splunk::package": }

class { "splunk": }
class { "splunk::app": }
class { "splunk::inputs": }
splunk::inputs::fragment {
  'messages':
    target => '/var/log/message';
  'boot':
    target => '/var/log/boot.log',
}
splunk::inputs::fragment { 'nosecure':
  port     => '9999',
  receiver => true,
}
