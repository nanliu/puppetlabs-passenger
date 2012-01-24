# Class: passenger::data
#
# The data class for passenger.
#
# Parameters:
#
# Actions:
#
# Requires:
#   - hiera
#   - hiera-puppet
#   - hiera configured to use puppet backend and data as default.
#
# Sample Usage:
#
class passenger::data {

  $passenger_version  = 'latest'
  $passenger_provider = 'gem'

  case $::osfamily {
    'redhat': {
      $passenger_bin_path = [ '/usr/lib/ruby/gems/1.8/gems/bin', '/usr/bin', '/bin' ]
      $passenger_so_file  = "/usr/lib/ruby/gems/1.8/gems/passenger-$version/ext/apache2/mod_passenger.so"
    }
    'debian': {
      $passenger_bin_path = [ '/var/lib/gems/1.8/bin', '/usr/bin', '/bin' ]
      $passenger_so_file  = "/var/lib/gems/1.8/gems/passenger-$version/ext/apache2/mod_passenger.so"
    }
  }

  case $::operatingsystem {
    'darwin':{
      $passenger_bin_path = [ '/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin', '/usr/bin', '/bin' ]
      $passenger_so_file  = "/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/passenger-$version/ext/apache2/mod_passenger.so"
    }
  }

}
