class profile_loadbalancer (

	$server		= [ 'app01', 'app02' ],
	$port		= "80",
	$site_name	= "demo",

){
#
#	class	{ 'nginx': }
#
#	nginx::resource::upstream { 'demo':
#		members	=> [
#			'app01',
#			'app02',
#		],
#	}
#
#	nginx::resource::server {
#		
#
#
	package { 'nginx':
		ensure	=> present,
		before	=> File["/etc/nginx/sites-available/${site_name}"],
	}

	file { "/etc/nginx/sites-available/${site_name}":
		ensure	=> file,
		content	=> template('profile_loadbalancer/nginx_conf.erb'),
		owner	=> root,
		group	=> root,
		mode	=> 644,
		before	=> File["/etc/nginx/sites-enabled/default"],
		require => Package['nginx'],
		notify	=> Service['nginx'],
	}

	file { "/etc/nginx/sites-enabled/default":
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
