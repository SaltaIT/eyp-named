class { 'named': }

named::zone { 'systemadmin.es':
  ns => [ '8.8.8.8', '8.8.4.4']
}
