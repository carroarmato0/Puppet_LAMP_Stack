class profile_database (

	$site_name	= "demo",

){

	class { '::mysql::server':
		override_options => {
			'mysqld' => {
                        	'bind-address'  => '0.0.0.0',
                	},
		},
		restart	=> true,
	}

	mysql::db { '${site_name}':
		user	 => '${site_name}',
		password => '${site_name}',
		host	 => '%',
		grant	 => 'ALL',
		require	 => Class['::mysql::server'],
	}

}
