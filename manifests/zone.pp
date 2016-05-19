# == Define: named::zone
#
# named::zone
#
# === Parameters
#
#
# [*zonename*]
#   Specify zonename, default's to resource's name
#
# [*zonemaster*]
#
#
#
# [*zonefile*]
#
#
#
# [*allowtransfer*]
#
#
#
# [*replace*]
#
#
#
# [*notifyslaves*]
#
#
#
# [*allowupdate*]
#
#
#
# [*alsonotify*]
#
#
#
#
#
# === Examples
#
# #add an additional server to notify for a specific zone
#  named::zone { 'example.local':
#    zonefile => 'puppet:///dnsmaster/example.local',
#    notifyslaves => true,
#    alsonotify => [ '192.168.56.15' ],
#  }
#
#
#
# === Authors
#
# Jordi Prats <jordi.prats@gmail.com>
#
# === Copyright
#
# Copyright 2015 Jordi Prats, unless otherwise noted.
#
define named::zone ($zonename=$name, $zonemaster=undef, $zonefile=undef,
      $allowtransfer=[ 'none' ], $replace=true,
      $notifyslaves=true,
      $allowupdate=undef,
      $alsonotify=undef,
      $ensure='present') {

  validate_string($zonename)

  if ($zonemaster)
  {
    validate_string($zonemaster)
  }

  if ($allowupdate)
  {
    validate_array($allowupdate)
  }

  if ($alsonotify)
  {
    validate_array($alsonotify)
  }

  if ($ensure == 'present')
  {
    concat::fragment{ "zone_$zonename":
      target  => "${named::params::confdir}/puppet-managed.zones",
      content => template("named/zone.erb")
    }
  }

  if $zonemaster==undef
  {
    if ($zonefile)
    {
      file { "${named::params::zonedir}/$zonename":
        ensure => $ensure,
        owner => "root",
        group => $named::params::osuser,
        mode => 0640,
        replace => $replace,
        notify => Service[$named::params::servicename],
        source => $zonefile
      }
    }
    else
    {
      file { "${named::params::zonedir}/$zonename":
        ensure => $ensure,
        owner => "root",
        group => $named::params::osuser,
        mode => 0640,
        replace => false,
        notify => Service[$named::params::servicename],
        content => template("named/zonetemplate.erb")
      }
    }
  }


}
