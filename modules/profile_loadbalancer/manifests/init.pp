#
# Loadbalancer Profile
#
class profile_loadbalancer (
	Array[String] $server     = [ 'app01', 'app02' ],
	Integer[1]    $port		    = 80,
	String        $site_name	= 'demo',
){

	package { 'nginx':
		ensure	=> present,
		before	=> File["/etc/nginx/sites-available/${site_name}"],
	}

	file { "/etc/nginx/sites-available/${site_name}":
		ensure	=> file,
		content	=> template('profile_loadbalancer/nginx_conf.erb'),
		owner	  => root,
		group  	=> root,
		mode	  => 644,
		before	=> File['/etc/nginx/sites-enabled/default'],
		require => Package['nginx'],
		notify	=> Service['nginx'],
	}

	file { '/etc/nginx/sites-enabled/default':
		ensure	=> absent,
		before	=> File["/etc/nginx/sites-enabled/${site_name}"],
		require => Package['nginx'],
		notify	=> Service['nginx'],
	}

	file { "/etc/nginx/sites-enabled/${site_name}":
		ensure	=> 'link',
		target	=> "/etc/nginx/sites-available/${site_name}",
		require	=> Package['nginx'],
		notify	=> Service['nginx'],
	}

	service { 'nginx':
		ensure	=> running,
		enable	=> true,
	}
}
