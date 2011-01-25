# Class: splunk::package
#
#   Manage the splunk package.
#
# Parameters:
#
# Actions:
#
#   Installs Splunk from package.
#
# Requires:
#
#   Class[splunk::users]
#   User["splunk"]
#
# Sample Usage:
#
class splunk::package(
  $pkg_name   = "splunk",
  $pkg_file   = "splunk-4.1.6-89596-linux-2.6-x86_64.rpm",
  $version    = "4.1.6",
  $has_repo   = false,
  $ensure     = "present"
) {
  # JJM Note, this should break out to platform specific
  # secondary classes.  They should NOT be subclasses.

  if ! ($ensure == "absent" or $ensure == "present") {
    fail("ensure param must be 'absent' or 'present'")
  }

  # JJM Ideally, the customer would have a local yum repository,
  # but this is often not the case, so we need to install
  # from URL.

  # JJM FIXME, this needs to not assume RPM.
  if ($has_repo == false) {
    $provider   = "rpm",
    $pkg_source = "http://tia.cat.pdx.edu/${pkg_file}",
  } elsif ($has_repo == true) {
    $provider   = "yum"
    $pkg_source = undef
  } else {
    fail("has_repo param must be true or false")
  }

  # End sanity checking
  # Begin resource declarations

  package { "splunk":
    name     => $pkg_name,
    ensure   => $ensure,
    provider => $provider,
    source   => $pkg_source,
  }

  # Relationships
  if ($ensure == "present") {
    User["splunk"] -> Package["splunk"]
  }
}
