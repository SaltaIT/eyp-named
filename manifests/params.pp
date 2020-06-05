class named::params {

  case $::osfamily
  {
    'redhat':
    {
      $packages= [ 'bind',  ]
      $utils_packages = [ 'bind-utils' ]
      case $::operatingsystemrelease
      {
        /^[678].*$/:
        {
          $confdir='/etc/named'
          $servicename='named'
          $directory='/var/named'

          $zonedir='/var/named'

          $options_file='/etc/named.conf'
          $localconfig_file='/etc/named.conf'

          $osuser='named'

          $managed_keys_dir='/var/named/dynamic'

          $sysconfig_file=undef
          $sysconfig_template=undef
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $packages= [ 'bind9' ]
      $utils_packages = [ 'bind9utils', 'dnsutils' ]

      $confdir='/etc/bind'
      $servicename='bind9'
      $directory='/var/cache/bind'

      $zonedir='/etc/bind'

      $options_file='/etc/bind/named.conf.options'
      $localconfig_file='/etc/bind/named.conf.local'

      $osuser='bind'

      $sysconfig_file='/etc/default/bind9'
      $sysconfig_template='debian.erb'
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[468].*$/:
            {
            }
            /^20.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian':
        {
          case $::operatingsystemrelease
          {
            /^10.*$/:
            {
            }
            default: { fail("Unsupported Debian version! - ${::operatingsystemrelease}")  }
          }
        }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
