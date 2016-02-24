define users::managed_user (
  $username = $title,
  $homedir = "/home/${title}",
  $group = $username,
  ) {

  user { $username:
    ensure => present,
    managehome => false,
    group => $group,
  }
  
  file  { $homedir:
    ensure => directory,
    require => User[$user],
  }
}
