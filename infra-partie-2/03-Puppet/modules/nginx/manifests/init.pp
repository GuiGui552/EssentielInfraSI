class nginx {
  if $facts['os']['family'] == 'windows' {
    file { 'C:/puppet-demo-nginx.html':
      ensure  => file,
      content => "<h1>Démo Puppet sur Windows (fichier géré)</h1>\n",
    }
  } elsif $facts['os']['family'] == 'Darwin' {
    file { '/tmp/nginx-puppet.html':
      ensure  => file,
      content => "<h1>Démo Puppet macOS (fichier géré)</h1>\n",
    }
  } else {
    package { 'nginx':
      ensure => installed,
    }
    service { 'nginx':
      ensure  => running,
      enable  => true,
      require => Package['nginx'],
    }
    file { '/var/www/html/index.html':
      ensure  => file,
      content => "<h1>Bienvenue sur le serveur Puppet Nginx !</h1>\n",
      require => Package['nginx'],
    }
  }
}
