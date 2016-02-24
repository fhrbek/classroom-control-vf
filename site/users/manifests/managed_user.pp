define users::managed_user (
  $username = $title,
  $homedir = "/home/${title}",
  $group = $title,
  ) {

  user { $username:
    ensure => present,
    managehome => false,
    groups => $group,
  }
  
  group { $group:
    ensure => present,
  }

  file  { $homedir:
    ensure => directory,
    require => User[$user],
  }
}
