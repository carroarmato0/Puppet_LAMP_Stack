#
# Profile Webserver
#
class profile_webserver (
	String        $site_name	  = 'demo',
	Integer[1]    $port		      = 80,
	Array[String] $python_mods	= [ 'flask', 'flask-sqlalchemy', 'sqlalchemy' ],
){

	class { '::apache':
		default_vhost	=> false,
	}

	class { '::apache::mod::wsgi':
		wsgi_python_home => "/var/www/${site_name}/.venv",
		wsgi_python_path => "/var/www/${site_name}/.venv/lib/python2.7/site-packages",
	}

	::apache::vhost { $site_name:
		port												=> $port,
		docroot											=> "/var/www/${site_name}",
		directories									=> [
			{
				path	=> "/var/www/${site_name}",
			  allow	=> 'from all',
			  order	=> 'deny,allow',
			},
		],
		wsgi_daemon_process					=> $site_name,
		wsgi_daemon_process_options	=> {
			'threads' => 5,
		},
		wsgi_application_group			=> '%{GLOBAL}',
		wsgi_process_group					=> $site_name,
		wsgi_script_aliases					=> {
			'/' => "/var/www/${site_name}/${site_name}.wsgi",
		},
		require											=> Class['::apache::mod::wsgi'],
	}

	file { "/var/www/${site_name}":
		ensure	=> directory,
		recurse	=> true,
		source	=> "puppet:///modules/profile_webserver/${site_name}",
		notify	=> Service['apache2'],
		before  => Apache::Vhost[$site_name],
	}

	class { '::python':
		pip					=> 'present',
		virtualenv	=> 'present',
	}

	::python::pip { $python_mods: }

	package { 'python-mysqldb':
		ensure	=> present,
		require	=> Class['python'],
	}

	::python::virtualenv { "/var/www/${site_name}":
		ensure		 => present,
		systempkgs => true,
		venv_dir	 => "/var/www/${site_name}/.venv",
		require		 => Package['python-mysqldb'],
		notify		 => Service['apache2'],
	}

}
