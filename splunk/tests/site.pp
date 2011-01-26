class { "splunk::users":
  virtual => false
}

class { "splunk::package": }

class { "splunk::service": }

class { "splunk": }
class { "splunk::app": }
class { "splunk::inputs": }
splunk::inputs::fragment {
  'messages':
    target => '/var/log/messages';
  'maillog':
    target => '/var/log/maillog',
}
# Needs documentation or receivers and
# targets could be different defines.
splunk::inputs::fragment { 'nosecure':
  port     => '9999',
  receiver => true,
}
