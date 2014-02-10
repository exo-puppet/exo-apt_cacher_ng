################################################################################
#
#   This module manages apt-cacher-ng as a LOCAL debian repo cache.
#
#   Tested platforms:
#    - Ubuntu 12.04
#    - Ubuntu 11.10 Oneiric
#    - Ubuntu 10.04 Lucid
#
#
# == Parameters
#   [+activated+]
#       (OPTIONAL) (default: true)
#
#       if true => apt-get / aptitude / ... configured to used apt-cacher-ng service and apt-cacher-ng daemon started
#       if false => apt-get / aptitude / ... configured to not use apt-cacher-ng service and apt-cacher-ng daemon stoped
#
#   [+port+]
#       (OPTIONAL) (default: 3142)
#
#       define the port to use for apt-cacher-ng
#
#   [+directory_mode+]
#       (OPTIONAL) (default: 644)
#
#       allow to change the /var/cache/directory directory mode for vagrant testing with NFS (use directory_mode=777)
#
# == Examples
#
#   class { "apt_cacher_ng":
#       activated => true,
#       port      => 3142,
#   }
#
################################################################################
class apt_cacher_ng (
  $activated      = true,
  $port           = 3142,
  # the directory right must be 777 for NFS sharing with Vagrant
  $directory_mode = 644) {
  # dependencies
  include repo
  include stdlib
  # internal classes
  include apt_cacher_ng::params, apt_cacher_ng::install, apt_cacher_ng::config, apt_cacher_ng::service
}
