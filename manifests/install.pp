class apt_cacher_ng::install {
  include apt_cacher_ng::params

  case $::operatingsystem {
    /(Ubuntu)/ : {
      ensure_packages( 'apt-cacher-ng', {'ensure' => 'present'} )
    }
    default    : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
