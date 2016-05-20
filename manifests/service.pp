class apt_cacher_ng::service {
  include apt_cacher_ng::install

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
  }
}
