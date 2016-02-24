define users::managed_user (
  $username = $title,
  $homedir = "/home/${username}",
  $group = $username,
  ) {

  user { $title:
    ensure => present,
    managehome => false,
    group => $group,
  }
  
  file  { $homedir:
    ensure => directory,
    require => User[$user],
  }
}
