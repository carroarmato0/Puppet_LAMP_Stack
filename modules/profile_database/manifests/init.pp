class profile_database (
	String $site_name	= 'demo',
){

	class { '::mysql::server':
		override_options => {
			'mysqld' => {
        'bind-address' => '0.0.0.0',
      },
		},
		restart					 => true,
	}

	::mysql::db { $site_name:
		user	   => $site_name,
		password => $site_name, # Do not do this in production unless you work for the government
		host	   => '%',
		grant	   => 'ALL',
		require	 => Class['::mysql::server'],
	}

}
