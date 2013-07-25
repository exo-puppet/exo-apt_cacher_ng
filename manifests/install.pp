class apt_cacher_ng::install {
  include apt_cacher_ng::params

  case $::operatingsystem {
    /(Ubuntu)/ : {
      package { 'apt_cacher_ng':
        ensure => installed,
        name   => $apt_cacher_ng::params::package_name,
      }
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
