class apt_cacher_ng::config {
  include apt_cacher_ng::install

  file { '/var/cache/apt-cacher-ng':
    ensure => directory,
    path   => $apt_cacher_ng::params::cache_dir,
    mode   => $apt_cacher_ng::directory_mode,
  } -> # Configure apt-cacher-ng to enforce umask and directory + file permissions
  file { '/etc/default/apt-cacher-ng':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/default/apt-cacher-ng.erb"),
    notify  => Service['apt-cacher-ng'],
  } -> # apt-cacher-ng Configuration
  file { '/etc/apt-cacher-ng/acng.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/apt-cacher-ng/acng.conf.erb"),
    require => Package[$apt_cacher_ng::params::package_name],
    notify  => Service[$apt_cacher_ng::params::service_name],
  }

}
