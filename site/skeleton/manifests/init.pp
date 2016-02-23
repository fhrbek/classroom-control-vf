class skeleton {

  file { '/etc/skel':
    ensure => directory,
  }
  
  file { '/etc/.bashrc':
    ensure => file,
    source => 'puppet:///modules/skeleton/bashrc',
}
