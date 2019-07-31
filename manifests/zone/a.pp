define named::zone::a (
                                $value,
                                $record   = $name,
                                $zonename,
                                $ttl      = undef,
                                $class    = 'IN',
                              ) {

  concat::fragment{ "srv record ${named::params::zonedir}/${zonename} - ${service} ${port} ${protocol} ${target} ${name} ${ttl} ${priority} ${weight}":
    target  => "${named::params::zonedir}/${zonename}",
    content => template("${module_name}/zone/arecord.erb"),
    order   => '99',
  }
}
