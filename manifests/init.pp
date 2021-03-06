class memcached(
  $package_ensure           = 'present',
  $logfile                  = '/var/log/memcached.log',
  $max_memory               = false,
  $lock_memory              = false,
  $listen_ip                = '0.0.0.0',
  $tcp_port                 = 11211,
  $udp_port                 = 11211,
  $user                     = $::memcached::params::user,
  $max_connections          = '8192',
  $verbosity                = undef,
  $unix_socket              = undef,
  $install_default_instance = true,
  $install_dev              = false
) inherits memcached::params {

  package { $memcached::params::package_name:
    ensure => $package_ensure,
  }

  if $install_default_instance {
    memcached::instance { "default":
      instance_ensure => 'present',
      logfile         => $logfile,
      max_memory      => $max_memory,
      lock_memory     => $lock_memory,
      listen_ip       => $listen_ip,
      tcp_port        => $tcp_port,
      udp_port        => $udp_port,
      user            => $user,
      max_connections => $max_connections,
      verbosity       => $verbosity,
      unix_socket     => $unix_socket,
    }

  if $install_dev {
    package { $memcached::params::dev_package_name:
      ensure  => $package_ensure,
      require => Package[$memcached::params::package_name]
    }
  }
  }
}
