# puppet/manifests/init.pp
package { 'ufw':
  ensure => installed,
}

service { 'ufw':
  ensure => running,
  enable => true,
}

# Ensure OpenSSH server is installed
package { 'openssh-server':
  ensure => installed,
}

# SSH configuration file
file { '/etc/ssh/sshd_config':
  ensure  => file,
  mode    => '0600',
  owner   => 'root',
  group   => 'root',
  content => template('/tmp/manifests/sshd_config.erb'),
  notify  => Service['ssh'],
}

# SSH banner
file { '/etc/issue.net':
  ensure  => file,
  content => "️Authorized access only. All activity will be monitored.\n",
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  notify  => Service['ssh'],
}

# Ensure SSH service is running and restarts on config change
service { 'ssh':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
}

