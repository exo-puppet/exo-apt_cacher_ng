class apt_cacher_ng::config {
  include apt_cacher_ng::install

  file { '/var/cache/apt-cacher-ng':
    ensure => directory,
    path   => $apt_cacher_ng::params::cache_dir,
    mode   => $apt_cacher_ng::directory_mode,
  } -> # Configure apt-cacher-ng to enforce umask and directory + file permissions
  file_line { 'apt-cacher-ng-default_umask':
    ensure => present,
    path   => '/etc/default/apt-cacher-ng',
    line   => 'umask 000',
    match  => '^umask ',
    notify  => Service['apt-cacher-ng'],
  } ->
  file_line { 'apt-cacher-ng-default_daemon':
    ensure => present,
    path   => '/etc/default/apt-cacher-ng',
    line   => "DAEMON_OPTS=' -c ${apt_cacher_ng::params::configuration_dir} '",
    match  => '^DAEMON_OPTS=',
    notify  => Service['apt-cacher-ng'],
  } -> # apt-cacher-ng Configuration
  file_line { 'apt-cacher-ng_cache-dir':
    ensure => present,
    path   => '/etc/apt-cacher-ng/acng.conf',
    line   => "CacheDir:${apt_cacher_ng::params::cache_dir}",
    match  => '^CacheDir:',
    notify  => Service['apt-cacher-ng'],
  } ->
  file_line { 'apt-cacher-ng_log-dir':
    ensure => present,
    path   => '/etc/apt-cacher-ng/acng.conf',
    line   => "LogDir:${apt_cacher_ng::params::log_dir}",
    match  => '^LogDir:',
    notify  => Service['apt-cacher-ng'],
  } ->
  file_line { 'apt-cacher-ng_port':
    ensure => present,
    path   => '/etc/apt-cacher-ng/acng.conf',
    line   => "Port:${apt_cacher_ng::params::port}",
    match  => '^Port:',
    notify  => Service['apt-cacher-ng'],
  }

}
