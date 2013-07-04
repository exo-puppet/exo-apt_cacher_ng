class apt_cacher_ng::params {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      $package_name           = [
        'apt-cacher-ng']
      $service_name           = 'apt-cacher-ng'
      $configuration_dir      = '/etc/apt-cacher-ng'
      $configuration_file     = "${configuration_dir}/acng.conf"
      $configuration_file_apt = '/etc/apt/apt.conf.d/02apt-cacher-ng'
      $cache_dir              = '/var/cache/apt-cacher-ng'
      $log_dir                = '/var/log/apt-cacher-ng'
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
