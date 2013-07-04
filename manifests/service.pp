class apt_cacher_ng::service {
  include apt_cacher_ng::install

  $apt_content = "Acquire::http::Proxy \"http://localhost:${apt_cacher_ng::port}\"; "

  service { 'apt-cacher-ng':
    ensure     => $apt_cacher_ng::activated ? {
      true    => running,
      default => stopped
    },
    name       => $apt_cacher_ng::params::service_name,
    hasstatus  => false,
    hasrestart => false,
    require    => [
      Class['apt_cacher_ng::install', 'apt_cacher_ng::config']]
  } -> # Configure apt-cacher-ng for apt
  file { 'apt.conf.d_apt-cacher-ng':
    ensure  => $apt_cacher_ng::activated ? {
      true    => present,
      default => absent
    },
    path    => $apt_cacher_ng::params::configuration_file_apt,
    content => $apt_content,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    require => [
      Package['apt-cacher-ng'],
      Service['apt-cacher-ng']],
  }
}
