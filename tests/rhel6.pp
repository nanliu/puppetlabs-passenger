include passenger
class setup-puppet {

  Class['passenger'] -> Class['setup-puppet']

  package { ['puppet', 'puppet-server']:
    ensure => latest,
  }

  service { 'puppetmaster':
    ensure    => stopped,
    enable    => false,
    hasstatus => true,
    require   => Package['puppet-server'],
  }

  File {
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    require => Package['puppet'],
  }

  file { '/etc/puppet/rack':
    ensure => directory,
  }

  file { '/etc/puppet/rack/public':
    ensure => directory,
  }

  file { '/etc/puppet/rack/tmp/':
    ensure => directory,
  }

  file { '/etc/puppet/rack/config.ru':
    source => '/usr/share/puppet/ext/rack/files/config.ru',
    notify => Service['httpd'],
  }
}

include setup-puppet
