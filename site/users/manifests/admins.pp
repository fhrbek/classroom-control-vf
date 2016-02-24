class users::admins {

  users::managed_user { 'jose': }

  users::managed_user { 'alice':
    group => 'nobody',
  }

  users::managed_user { 'chen':
    homedir => '/tmp/chen',
  }
}
