class nginx {
  $ng = 'nginx'

  File {
    owner => '0',
    group => '0',
    mode => '0644',
    ensure => file,
  }
  
  package { $ng:
    ensure => present,
  }
  
  file { ['/var/www', "/etc/${ng}"]:
    ensure => directory,
    require => Package[$ng],
  }
  
  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "/etc/${ng}/${ng}.conf":
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  file { "/etc/${ng}/conf.d/default.conf":
    source => 'puppet:///modules/nginx/default.conf',
  }

  service { $ng:
    ensure => running,
    require => File['/var/www/index.html'],
    subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
  }
}
