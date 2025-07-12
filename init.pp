# puppet/manifests/init.pp
package { 'ufw':
  ensure => installed,
}

service { 'ufw':
  ensure => running,
  enable => true,
}

