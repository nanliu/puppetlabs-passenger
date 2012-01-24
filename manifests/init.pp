# Class: passenger
#
# Installs phusion passenger
#
# Parameters:
#   version: passenger version (present, latest, version).
#   provider: passenger packcage provider (default: gem).
#   bin_path: passenger binary path.
#   so_file: passenger.so file created by compilation process.
#
# Actions:
#   - Install phusion passenger
#   - Compile passenger module
#
# Requires:
#   - apache::dev
#   - ruby::dev
#   - gcc
#
# Sample Usage:
#   class { 'passenger':
#     version  => '2.2.11',
#     provider => 'gem',
#     bin_path => [ '/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin', '/usr/bin', '/bin' ],
#     so_file  => "/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/passenger-$version/ext/apache2/mod_passenger.so",
#   }
#
class passenger (
  $version  = hiera('passenger_version'),
  $provider = hiera('passenger_provider'),
  $bin_path = hiera_array('passenger_bin_path'),
  $so_file  = hiera('passenger_so_path')
) {

  include apache::dev
  include ruby::dev
  include gcc

  Class['gcc']       -> Class['passenger']
  Class['ruby::dev'] -> Class['passenger']

  package { 'passenger':
    ensure   => $version,
    provider => $provider,
  }

  exec { 'compile-passenger':
    command   => 'passenger-install-apache2-module -a',
    path      => $bin_path,
    logoutput => true,
    creates   => $so_file,
    require   => Package['passenger'],
  }

}
