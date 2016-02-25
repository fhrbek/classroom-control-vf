class nginx (
  $root = $nginx::params::default_docroot
) inherits nginx::params {

  File {
    owner => '0',
    group => '0',
    mode => '0644',
    ensure => file,
  }
  
  package { $ng:
    ensure => present,
  }
  
  file { [$root, $confdir]:
    ensure => directory,
    require => Package[$ng],
  }
  
  file { "${root}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${confdir}/${ng}.conf":
    content => template('nginx/nginx.conf.erb'),
  }

  file { "${confdir}/conf.d/default.conf":
    content => template('nginx/default.conf.erb'),
  }

  service { $ng:
    ensure => running,
    require => File["${root}/index.html"],
    subscribe => File["${confdir}/${ng}.conf", "${confdir}/conf.d/default.conf"],
  }
}
