# Define: splunk::fragment
#
#   Creates framents that become entries in
#   inputs.conf as part of the Splunk App
#   created by Puppet. Entries included are
#   files to be indexed or ports that
#   Splunk wil receiver forwarders on.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2010-12-22
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

define splunk::fragment(
  $ensure = 'present',
  $config_id,
  $app_id,
  $fragment_id = '',
  $content,
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enabled must be present or absent")
  }

  # Need to modify app.pp to set up app specific
  # fragent directories to support this new pattern.

  if ($fragment_id == '') {
    $fragment_id_real = $name
  } else {
    $fragment_id_real = $fragment_id
  }

  file { "${splunk::fragpath}/${app_id}/${config_id}.d/${fragment_id_real}":
    ensure  => $ensure,
    owner   => splunk,
    group   => splunk,
    mode    => '0644',
    content => $content,
    notify  => Exec["rebuild_${app_id}_${config_id}"],
  }
}
