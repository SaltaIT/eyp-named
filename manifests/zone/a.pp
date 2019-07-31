define named::zone::a (
                                $value,
                                $zonename,
                                $record   = $name,
                                $ttl      = undef,
                                $class    = 'IN',
                              ) {

  concat::fragment{ "A ${record}/${value} record ${named::params::zonedir}/${zonename}":
    target  => "${named::params::zonedir}/${zonename}",
    content => template("${module_name}/zone/arecord.erb"),
    order   => '99',
  }
}
