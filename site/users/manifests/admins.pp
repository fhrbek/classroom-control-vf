class users::admins {

  managed_user { 'jose': }

  managed_user { 'alice':
    group => 'nobody',
  }

  managed_user { 'chen':
    homedir => '/tmp/chen',
  }
}
