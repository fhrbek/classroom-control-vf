class nginx {
  File {
    owner => '0',
    group => '0',
    mode => '0644',
    ensure => file,
  }
  
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
  }
  
  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx':
    ensure => directory,
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/nginx.conf':
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
  }

  service { 'nginx':
    ensure => running,
    require => File['/var/www/index.html'],
    subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
  }
}
