#
# Baseline
#
class profile_base (
){

	class { '::locales':
		default_locale	=> 'en_US.UTF-8',
		lc_all					=> 'en_US.UTF-8',
		locales					=> [ 'en_US.UTF-8 UTF-8', 'de_BE.UTF-8 UTF-8', 'fr_BE.UTF-8 UTF-8' ],
	}

	class { '::timezone':
		timezone	=> 'Europe/Brussels',
	}

	include ::ntp

}
