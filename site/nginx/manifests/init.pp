class nginx {
  $ng = 'nginx'
  $is_windows = $::os['family'] == 'Windows'
  if $is_windows {
    $docroot = 'C:/ProgramData/nginx/html'
    $confdir = 'C:/ProgramData/nginx'
    $logdir = "${confdir}/logs"
    $service_user = 'nobody'
  } else {
    $docroot = '/var/www'
    $confdir = '/etc/nginx'
    $logdir = '/var/log/nginx'
    $service_user = $::os['family'] ? {
      'Debian' => 'www-data',
      default => 'nginx',
    }
  }

  File {
    owner => '0',
    group => '0',
    mode => '0644',
    ensure => file,
  }
  
  package { $ng:
    ensure => present,
  }
  
  file { [$docroot, $confdir]:
    ensure => directory,
    require => Package[$ng],
  }
  
  file { "${docroot}/index.html":
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
    require => File["${docroot}/index.html"],
    subscribe => File["${confdir}/${ng}.conf", "${confdir}/conf.d/default.conf"],
  }
}
