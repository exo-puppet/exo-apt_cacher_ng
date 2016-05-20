class apt_cacher_ng::params {
  case $::operatingsystem {
    /(Ubuntu)/ : {
      $service_name           = 'apt-cacher-ng'
      $configuration_dir      = '/etc/apt-cacher-ng'
      $configuration_file     = "${configuration_dir}/acng.conf"
      $cache_dir              = '/var/cache/apt-cacher-ng'
      $log_dir                = '/var/log/apt-cacher-ng'
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
