class nginx::params {
  $ng = 'nginx'
  $is_windows = $::os['family'] == 'Windows'
  if $is_windows {
    $default_docroot = 'C:/ProgramData/nginx/html'
    $confdir = 'C:/ProgramData/nginx'
    $logdir = "${confdir}/logs"
    $service_user = 'nobody'
  } else {
    $default_docroot = '/var/www'
    $confdir = '/etc/nginx'
    $logdir = '/var/log/nginx'
    $service_user = $::os['family'] ? {
      'Debian' => 'www-data',
      default => 'nginx',
    }
  }
}