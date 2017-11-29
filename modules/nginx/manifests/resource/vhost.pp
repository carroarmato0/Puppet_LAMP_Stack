# define: nginx::resource::vhost
#
# This definition creates a virtual host
#
# Parameters:
#   [*ensure*]              - Enables or disables the specified vhost
#     (present|absent)
#   [*listen_ip*]           - Default IP Address for NGINX to listen with this
#     vHost on. Defaults to all interfaces (*)
#   [*listen_port*]         - Default IP Port for NGINX to listen with this
#     vHost on. Defaults to TCP 80
#   [*listen_options*]      - Extra options for listen directive like
#     'default_server' to catchall. Undef by default.
#   [*listen_unix_socket_enable*] - BOOL value to enable/disable UNIX socket
#     listening support (false|true).
#   [*listen_unix_socket*]  - Default unix socket for NGINX to listen with this
#     vHost on. Defaults to UNIX /var/run/nginx.sock
#   [*listen_unix_socket_options*] - Extra options for listen directive like
#     'default' to catchall. Undef by default.
#   [*location_satisfy*]    - Allows access if all (all) or at least one (any) of the auth modules allow access.
#   [*location_allow*]      - Array: Locations to allow connections from.
#   [*location_deny*]       - Array: Locations to deny connections from.
#   [*ipv6_enable*]         - BOOL value to enable/disable IPv6 support
#     (false|true). Module will check to see if IPv6 support exists on your
#     system before enabling.
#   [*ipv6_listen_ip*]      - Default IPv6 Address for NGINX to listen with
#     this vHost on. Defaults to all interfaces (::)
#   [*ipv6_listen_port*]    - Default IPv6 Port for NGINX to listen with this
#     vHost on. Defaults to TCP 80
#   [*ipv6_listen_options*] - Extra options for listen directive like 'default'
#     to catchall. Template will allways add ipv6only=on. While issue
#     jfryman/puppet-nginx#30 is discussed, default value is 'default'.
#   [*add_header*]          - Hash: Adds headers to the HTTP response when
#     response code is equal to 200, 204, 301, 302 or 304.
#   [*index_files*]         - Default index files for NGINX to read when
#     traversing a directory
#   [*autoindex*]           - Set it on 'on' or 'off 'to activate/deactivate
#                             autoindex directory listing. Undef by default.
#   [*proxy*]               - Proxy server(s) for the root location to connect
#     to.  Accepts a single value, can be used in conjunction with
#     nginx::resource::upstream
#   [*proxy_read_timeout*]  - Override the default the proxy read timeout value
#     of 90 seconds
#   [*proxy_redirect*]      - Override the default proxy_redirect value of off.
#   [*proxy_buffering*]     - If defined, sets the proxy_buffering to the passed value.
#   [*resolver*]            - Array: Configures name servers used to resolve
#     names of upstream servers into addresses.
#   [*fastcgi*]             - location of fastcgi (host:port)
#   [*fastcgi_params*]      - optional alternative fastcgi_params file to use
#   [*fastcgi_script*]      - optional SCRIPT_FILE parameter
#   [*uwsgi_read_timeout*]  - optional value for uwsgi_read_timeout
#   [*ssl*]                 - Indicates whether to setup SSL bindings for this
#     vhost.
#   [*ssl_cert*]            - Pre-generated SSL Certificate file to reference
#     for SSL Support. This is not generated by this module.  Set to `false` to
#     inherit from the http section, which improves performance by conserving
#     memory.
#   [*ssl_client_cert*]     - Pre-generated SSL Certificate file to reference
#     for client verify SSL Support. This is not generated by this module.
#   [*ssl_verify_client*]   - Enables verification of client certificates.
#   [*ssl_crl*]             - String: Specifies CRL path in file system
#   [*ssl_dhparam*]         - This directive specifies a file containing
#     Diffie-Hellman key agreement protocol cryptographic parameters, in PEM
#     format, utilized for exchanging session keys between server and client.
#   [*ssl_key*]             - Pre-generated SSL Key file to reference for SSL
#     Support. This is not generated by this module. Set to `false` to inherit
#     from the http section, which improves performance by conserving memory.
#   [*ssl_port*]            - Default IP Port for NGINX to listen with this SSL
#     vHost on. Defaults to TCP 443
#   [*ssl_protocols*]       - SSL protocols enabled. Defaults to 'TLSv1 TLSv1.1
#     TLSv1.2'.
#   [*ssl_buffer_size*]     - Sets the size of the buffer used for sending data.
#   [*ssl_ciphers*]         - SSL ciphers enabled. Defaults to
#     nginx::config::ssl_ciphers
#   [*ssl_stapling*]        - Bool: Enables or disables stapling of OCSP
#     responses by the server. Defaults to false.
#   [*ssl_stapling_file*]   - String: When set, the stapled OCSP response
#     will be taken from the specified file instead of querying the OCSP
#     responder specified in the server certificate.
#   [*ssl_stapling_responder*] - String: Overrides the URL of the OCSP
#     responder specified in the Authority Information Access certificate
#     extension.
#   [*ssl_stapling_verify*] - Bool: Enables or disables verification of
#     OCSP responses by the server. Defaults to false.
#   [*ssl_session_timeout*] - String: Specifies a time during which a client
#     may reuse the session parameters stored in a cache. Defaults to 5m.
#   [*ssl_session_tickets*] - String: Enables or disables session resumption
#     through TLS session tickets.
#   [*ssl_session_ticket_key*] - String: Sets a file with the secret key used
#     to encrypt and decrypt TLS session tickets.
#   [*ssl_trusted_cert*]    - String: Specifies a file with trusted CA
#     certificates in the PEM format used to verify client certificates and
#     OCSP responses if ssl_stapling is enabled.
#   [*spdy*]                - Toggles SPDY protocol.
#   [*http2*]               - Toggles HTTP/2 protocol.
#   [*server_name*]         - List of vhostnames for which this vhost will
#     respond. Default [$name].
#   [*www_root*]            - Specifies the location on disk for files to be
#     read from. Cannot be set in conjunction with $proxy
#   [*rewrite_www_to_non_www*]  - Adds a server directive and rewrite rule to
#     rewrite www.domain.com to domain.com in order to avoid duplicate
#     content (SEO);
#   [*try_files*]               - Specifies the locations for files to be
#     checked as an array. Cannot be used in conjuction with $proxy.
#   [*proxy_cache*]             - This directive sets name of zone for caching.
#     The same zone can be used in multiple places.
#   [*proxy_cache_key*]     - Override the default proxy_cache_key of
#     $scheme$proxy_host$request_uri
#   [*proxy_cache_use_stale*] - Override the default proxy_cache_use_stale value
#     of off.
#   [*proxy_cache_valid*]       - This directive sets the time for caching
#     different replies.
#   [*proxy_method*]            - If defined, overrides the HTTP method of the
#     request to be passed to the backend.
#   [*proxy_http_version*]      - Sets the proxy http version
#   [*proxy_set_body*]          - If defined, sets the body passed to the backend.
#   [*auth_basic*]              - This directive includes testing name and
#      password with HTTP Basic Authentication.
#   [*auth_basic_user_file*]    - This directive sets the htpasswd filename for
#     the authentication realm.
#   [*client_max_body_size*]    - This directive sets client_max_body_size.
#   [*client_body_timeout*]     - Sets how long the server will wait for a
#      client body. Default is 60s
#   [*client_header_timeout*]     - Sets how long the server will wait for a
#      client header. Default is 60s
#   [*raw_prepend*]            - A single string, or an array of strings to
#     prepend to the server directive (after cfg prepend directives). NOTE:
#     YOU are responsible for a semicolon on each line that requires one.
#   [*raw_append*]             - A single string, or an array of strings to
#     append to the server directive (after cfg append directives). NOTE:
#     YOU are responsible for a semicolon on each line that requires one.
#   [*location_raw_prepend*]          - A single string, or an array of strings
#     to prepend to the location directive (after custom_cfg directives). NOTE:
#     YOU are responsible for a semicolon on each line that requires one.
#   [*location_raw_append*]           - A single string, or an array of strings
#     to append to the location directive (after custom_cfg directives). NOTE:
#     YOU are responsible for a semicolon on each line that requires one.
#   [*vhost_cfg_append*]        - It expects a hash with custom directives to
#     put after everything else inside vhost
#   [*vhost_cfg_prepend*]       - It expects a hash with custom directives to
#     put before everything else inside vhost
#   [*vhost_cfg_ssl_append*]        - It expects a hash with custom directives to
#     put after everything else inside vhost ssl
#   [*vhost_cfg_ssl_prepend*]       - It expects a hash with custom directives to
#     put before everything else inside vhost ssl
#   [*rewrite_to_https*]        - Adds a server directive and rewrite rule to
#     rewrite to ssl
#   [*include_files*]           - Adds include files to vhost
#   [*access_log*]              - Where to write access log (log format can be
#     set with $format_log). This can be either a string or an array; in the
#     latter case, multiple lines will be created. Additionally, unlike the
#     earlier behavior, setting it to 'absent' in the vhost context will remove
#     this directive entirely from the vhost stanza, rather than setting a
#     default. Can also be disabled for this vhost with the string 'off'.
#   [*error_log*]               - Where to write error log. May add additional
#     options like error level to the end. May set to 'absent', in which case
#     it will be omitted in this vhost stanza (and default to nginx.conf setting)
#   [*passenger_cgi_param*]     - Allows one to define additional CGI environment
#     variables to pass to the backend application
#   [*passenger_set_header*]        - Allows one to set headers to pass to the
#     backend application (Passenger 5.0+)
#   [*passenger_env_var*]       - Allows one to set environemnt variables to pass
#     to the backend application (Passenger 5.0+)
#   [*passenger_pre_start*]     - Allows setting a URL to pre-warm the host. Per
#     Passenger docs, the "domain part of the URL" must match a value of
#     server_name. If this is an array, multiple URLs can be specified.
#   [*log_by_lua*]              - Run the Lua source code inlined as the
#     <lua-script-str> at the log request processing phase.
#     This does not replace the current access logs, but runs after.
#   [*log_by_lua_file*]         - Equivalent to log_by_lua, except that the file
#     specified by <path-to-lua-script-file> contains the Lua code, or, as from
#     the v0.5.0rc32 release, the Lua/LuaJIT bytecode to be executed.
#   [*gzip_types*]              - Defines gzip_types, nginx default is text/html
#   [*owner*]                   - Defines owner of the .conf file
#   [*group*]                   - Defines group of the .conf file
#   [*mode*]                    - Defines mode of the .conf file
#   [*maintenance*]             - A boolean value to set a vhost in maintenance
#   [*maintenance_value*]       - Value to return when maintenance is on.
#                                 Default to return 503
#   [*error_pages*]             - Hash: setup errors pages, hash key is the http
#                                 code and hash value the page
#   [*locations*]               - Hash of vhosts ressources used by this vhost
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::vhost { 'test2.local':
#    ensure   => present,
#    www_root => '/var/www/nginx-default',
#    ssl      => true,
#    ssl_cert => '/tmp/server.crt',
#    ssl_key  => '/tmp/server.pem',
#  }
define nginx::resource::vhost (
  $ensure                       = 'present',
  $listen_ip                    = '*',
  $listen_port                  = 80,
  $listen_options               = undef,
  $listen_unix_socket_enable    = false,
  $listen_unix_socket           = '/var/run/nginx.sock',
  $listen_unix_socket_options   = undef,
  $location_satisfy             = undef,
  $location_allow               = [],
  $location_deny                = [],
  $ipv6_enable                  = false,
  $ipv6_listen_ip               = '::',
  $ipv6_listen_port             = 80,
  $ipv6_listen_options          = 'default ipv6only=on',
  $add_header                   = undef,
  $ssl                          = false,
  $ssl_listen_option            = true,
  $ssl_cert                     = undef,
  $ssl_client_cert              = undef,
  $ssl_verify_client            = 'on',
  $ssl_dhparam                  = undef,
  $ssl_key                      = undef,
  $ssl_port                     = 443,
  $ssl_protocols                = $::nginx::config::ssl_protocols,
  $ssl_buffer_size              = undef,
  $ssl_ciphers                  = $::nginx::config::ssl_ciphers,
  $ssl_cache                    = 'shared:SSL:10m',
  $ssl_crl                      = undef,
  $ssl_stapling                 = false,
  $ssl_stapling_file            = undef,
  $ssl_stapling_responder       = undef,
  $ssl_stapling_verify          = false,
  $ssl_session_timeout          = '5m',
  $ssl_session_tickets          = undef,
  $ssl_session_ticket_key       = undef,
  $ssl_trusted_cert             = undef,
  $spdy                         = $::nginx::config::spdy,
  $http2                        = $::nginx::config::http2,
  $proxy                        = undef,
  $proxy_redirect               = undef,
  $proxy_read_timeout           = $::nginx::config::proxy_read_timeout,
  $proxy_connect_timeout        = $::nginx::config::proxy_connect_timeout,
  $proxy_set_header             = $::nginx::config::proxy_set_header,
  $proxy_hide_header            = $::nginx::config::proxy_hide_header,
  $proxy_pass_header            = $::nginx::config::proxy_pass_header,
  $proxy_cache                  = false,
  $proxy_cache_key              = undef,
  $proxy_cache_use_stale        = undef,
  $proxy_cache_valid            = false,
  $proxy_method                 = undef,
  $proxy_http_version           = undef,
  $proxy_set_body               = undef,
  $proxy_buffering              = undef,
  $resolver                     = [],
  $fastcgi                      = undef,
  $fastcgi_params               = "${::nginx::config::conf_dir}/fastcgi_params",
  $fastcgi_script               = undef,
  $uwsgi                        = undef,
  $uwsgi_params                 = "${nginx::config::conf_dir}/uwsgi_params",
  $uwsgi_read_timeout           = undef,
  $index_files                  = [
    'index.html',
    'index.htm',
    'index.php'],
  $autoindex                    = undef,
  $server_name                  = [$name],
  $www_root                     = undef,
  $rewrite_www_to_non_www       = false,
  $rewrite_to_https             = undef,
  $location_custom_cfg          = undef,
  $location_cfg_prepend         = undef,
  $location_cfg_append          = undef,
  $location_custom_cfg_prepend  = undef,
  $location_custom_cfg_append   = undef,
  $try_files                    = undef,
  $auth_basic                   = undef,
  $auth_basic_user_file         = undef,
  $client_body_timeout          = undef,
  $client_header_timeout        = undef,
  $client_max_body_size         = undef,
  $raw_prepend                  = undef,
  $raw_append                   = undef,
  $location_raw_prepend         = undef,
  $location_raw_append          = undef,
  $vhost_cfg_prepend            = undef,
  $vhost_cfg_append             = undef,
  $vhost_cfg_ssl_prepend        = undef,
  $vhost_cfg_ssl_append         = undef,
  $include_files                = undef,
  $access_log                   = undef,
  $error_log                    = undef,
  $format_log                   = 'combined',
  $passenger_cgi_param          = undef,
  $passenger_set_header         = undef,
  $passenger_env_var            = undef,
  $passenger_pre_start          = undef,
  $log_by_lua                   = undef,
  $log_by_lua_file              = undef,
  $use_default_location         = true,
  $rewrite_rules                = [],
  $string_mappings              = {},
  $geo_mappings                 = {},
  $gzip_types                   = undef,
  $owner                        = $::nginx::config::global_owner,
  $group                        = $::nginx::config::global_group,
  $mode                         = $::nginx::config::global_mode,
  $maintenance                  = false,
  $maintenance_value            = 'return 503',
  $error_pages                  = undef,
  $locations                    = {}
) {

  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
  if !(is_array($listen_ip) or is_string($listen_ip)) {
    fail('$listen_ip must be a string or array.')
  }
  if is_string($listen_port) {
    warning('DEPRECATION: String $listen_port must be converted to an integer. Integer string support will be removed in a future release.')
  }
  elsif !is_integer($listen_port) {
    fail('$listen_port must be an integer.')
  }
  if ($listen_options != undef) {
    validate_string($listen_options)
  }
  validate_bool($listen_unix_socket_enable)
  if !(is_array($listen_unix_socket) or is_string($listen_unix_socket)) {
    fail('$listen_unix_socket must be a string or array.')
  }
  if ($listen_unix_socket_options != undef) {
    validate_string($listen_unix_socket_options)
  }
  if ($location_satisfy != undef) {
    validate_re($location_satisfy, '^(any|all)$',
    "${$location_satisfy} is not supported for location_satisfy. Allowed values are 'any' and 'all'.")
  }
  validate_array($location_allow)
  validate_array($location_deny)
  validate_bool($ipv6_enable)
  if !(is_array($ipv6_listen_ip) or is_string($ipv6_listen_ip)) {
    fail('$ipv6_listen_ip must be a string or array.')
  }
  if is_string($ipv6_listen_port) {
    warning('DEPRECATION: String $ipv6_listen_port must be converted to an integer. Integer string support will be removed in a future release.')
  }
  elsif !is_integer($ipv6_listen_port) {
    fail('$ipv6_listen_port must be an integer.')
  }
  validate_string($ipv6_listen_options)
  if ($add_header != undef) {
    validate_hash($add_header)
  }
  validate_bool($ssl)
  if $ssl_cert {
    validate_string($ssl_cert)
  }
  if ($ssl_client_cert != undef) {
    validate_string($ssl_client_cert)
  }
  if ($ssl_verify_client != undef) {
    validate_string($ssl_verify_client)
  }
  if ($ssl_crl != undef) {
    validate_string($ssl_crl)
  }
  validate_bool($ssl_listen_option)
  if ($ssl_dhparam != undef) {
    validate_string($ssl_dhparam)
  }
  if $ssl_key {
    validate_string($ssl_key)
  }
  if is_string($ssl_port) {
    warning('DEPRECATION: String $ssl_port must be converted to an integer. Integer string support will be removed in a future release.')
  }
  elsif !is_integer($ssl_port) {
    fail('$ssl_port must be an integer.')
  }
  validate_string($ssl_protocols)
  validate_string($ssl_ciphers)
  validate_string($ssl_cache)
  validate_bool($ssl_stapling)
  if ($ssl_stapling_file != undef) {
    validate_string($ssl_stapling_file)
  }
  if ($ssl_stapling_responder != undef) {
    validate_string($ssl_stapling_responder)
  }
  validate_bool($ssl_stapling_verify)
  validate_string($ssl_session_timeout)
  if ($ssl_session_tickets) {
    validate_string($ssl_session_tickets)
  }
  if ($ssl_session_ticket_key) {
    validate_string($ssl_session_ticket_key)
  }
  if ($ssl_trusted_cert != undef) {
    validate_string($ssl_trusted_cert)
  }
  validate_string($spdy)
  if ($proxy != undef) {
    validate_string($proxy)
  }
  validate_string($proxy_read_timeout)
  if ($proxy_redirect != undef) {
    validate_string($proxy_redirect)
  }
  validate_array($proxy_set_header)
  validate_array($proxy_hide_header)
  validate_array($proxy_pass_header)
  if ($proxy_cache != false) {
    validate_string($proxy_cache)
  }
  if ($proxy_cache_key != undef) {
    validate_string($proxy_cache_key)
  }
  if ($proxy_cache_use_stale != undef) {
    validate_string($proxy_cache_use_stale)
  }
  if ($proxy_cache_valid != false) {
    if !(is_array($proxy_cache_valid) or is_string($proxy_cache_valid)) {
      fail('$proxy_cache_valid must be a string or an array or false.')
    }
  }
  if ($access_log != undef) and !(is_array($access_log) or is_string($access_log)) {
    fail('$access_log must be a string or array.')
  }
  if ($error_log != undef) and !(is_array($error_log) or is_string($error_log)) {
    fail('$error_log must be a string or array.')
  }
  if ($proxy_method != undef) {
    validate_string($proxy_method)
  }
  if ($proxy_http_version != undef) {
    validate_string($proxy_http_version)
  }
  if ($proxy_set_body != undef) {
    validate_string($proxy_set_body)
  }
  if ($proxy_buffering != undef) {
    validate_re($proxy_buffering, '^(on|off)$')
  }
  validate_array($resolver)
  if ($fastcgi != undef) {
    validate_string($fastcgi)
  }
  validate_string($fastcgi_params)
  if ($fastcgi_script != undef) {
    validate_string($fastcgi_script)
  }
  if ($uwsgi != undef) {
    validate_string($uwsgi)
  }
  validate_string($uwsgi_params)
  if ($uwsgi_read_timeout != undef) {
    validate_string($uwsgi_read_timeout)
  }
  validate_array($index_files)
  if ($autoindex != undef) {
    validate_string($autoindex)
  }
  validate_array($server_name)
  if ($www_root != undef) {
    validate_string($www_root)
  }
  validate_bool($rewrite_www_to_non_www)
  if ($rewrite_to_https != undef) {
    validate_bool($rewrite_to_https)
  }
  if ($raw_prepend != undef) {
    if (is_array($raw_prepend)) {
      validate_array($raw_prepend)
    } else {
      validate_string($raw_prepend)
    }
  }
  if ($raw_append != undef) {
    if (is_array($raw_append)) {
      validate_array($raw_append)
    } else {
      validate_string($raw_append)
    }
  }
  if ($location_raw_prepend != undef) {
    if (is_array($location_raw_prepend)) {
      validate_array($location_raw_prepend)
    } else {
      validate_string($location_raw_prepend)
    }
  }
  if ($location_raw_append != undef) {
    if (is_array($location_raw_append)) {
      validate_array($location_raw_append)
    } else {
      validate_string($location_raw_append)
    }
  }
  if ($location_custom_cfg != undef) {
    validate_hash($location_custom_cfg)
  }
  if ($location_cfg_prepend != undef) {
    validate_hash($location_cfg_prepend)
  }
  if ($location_cfg_append != undef) {
    validate_hash($location_cfg_append)
  }
  if ($try_files != undef) {
    validate_array($try_files)
  }
  if ($auth_basic != undef) {
    validate_string($auth_basic)
  }
  if ($auth_basic_user_file != undef) {
    validate_string($auth_basic_user_file)
  }
  if ($vhost_cfg_prepend != undef) {
    validate_hash($vhost_cfg_prepend)
  }
  if ($vhost_cfg_append != undef) {
    validate_hash($vhost_cfg_append)
  }
  if ($vhost_cfg_ssl_prepend != undef) {
    validate_hash($vhost_cfg_ssl_prepend)
  }
  if ($vhost_cfg_ssl_append != undef) {
    validate_hash($vhost_cfg_ssl_append)
  }
  if ($include_files != undef) {
    validate_array($include_files)
  }
  if ($passenger_cgi_param != undef) {
    validate_hash($passenger_cgi_param)
  }
  if ($passenger_set_header != undef) {
    validate_hash($passenger_set_header)
  }
  if ($passenger_env_var != undef) {
    validate_hash($passenger_env_var)
  }
  if ($passenger_pre_start != undef) {
    if (is_array($passenger_pre_start)) {
      validate_array($passenger_pre_start)
    } else {
      validate_string($passenger_pre_start)
    }
  }
  if ($log_by_lua != undef) {
    validate_string($log_by_lua)
  }
  if ($log_by_lua_file != undef) {
    validate_string($log_by_lua_file)
  }
  if ($client_body_timeout != undef) {
    validate_string($client_body_timeout)
  }
  if ($client_header_timeout != undef) {
    validate_string($client_header_timeout)
  }
  if ($gzip_types != undef) {
    validate_string($gzip_types)
  }
  validate_bool($use_default_location)
  validate_array($rewrite_rules)
  validate_hash($string_mappings)
  validate_hash($geo_mappings)
  validate_hash($locations)

  validate_string($owner)
  validate_string($group)
  validate_re($mode, '^\d{4}$',
    "${mode} is not valid. It should be 4 digits (0644 by default).")

  # Variables
  if $::nginx::config::confd_only {
    $vhost_dir = "${::nginx::config::conf_dir}/conf.d"
  } else {
    $vhost_dir = "${::nginx::config::conf_dir}/sites-available"
    $vhost_enable_dir = "${::nginx::config::conf_dir}/sites-enabled"
    $vhost_symlink_ensure = $ensure ? {
      'absent' => absent,
      default  => 'link',
    }
  }

  $name_sanitized = regsubst($name, ' ', '_', 'G')
  $config_file = "${vhost_dir}/${name_sanitized}.conf"

  File {
    ensure => $ensure ? {
      'absent' => absent,
      default  => 'file',
    },
    notify => Class['::nginx::service'],
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled
  # and support does not exist for it in the kernel.
  if ($ipv6_enable == true) and (!$::ipaddress6) {
    warning('nginx: IPv6 support is not enabled or configured properly')
  }

  # Check to see if SSL Certificates are properly defined.
  if ($ssl == true) {
    if ($ssl_cert == undef)  {
      fail('nginx: ssl_cert must be set to false or to a fully qualified path')
    }
    if ($ssl_key == undef) {
      fail('nginx: ssl_key must be set to false or to a fully qualified path')
    }
  }

  concat { $config_file:
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    notify  => Class['::nginx::service'],
    require => File[$vhost_dir],
  }

  $ssl_only = ($ssl == true) and (($ssl_port + 0) == ($listen_port + 0))

  if $use_default_location == true {
    # Create the default location reference for the vHost
    nginx::resource::location {"${name_sanitized}-default":
      ensure                      => $ensure,
      vhost                       => $name_sanitized,
      ssl                         => $ssl,
      ssl_only                    => $ssl_only,
      location                    => '/',
      location_satisfy            => $location_satisfy,
      location_allow              => $location_allow,
      location_deny               => $location_deny,
      proxy                       => $proxy,
      proxy_redirect              => $proxy_redirect,
      proxy_read_timeout          => $proxy_read_timeout,
      proxy_connect_timeout       => $proxy_connect_timeout,
      proxy_cache                 => $proxy_cache,
      proxy_cache_key             => $proxy_cache_key,
      proxy_cache_use_stale       => $proxy_cache_use_stale,
      proxy_cache_valid           => $proxy_cache_valid,
      proxy_method                => $proxy_method,
      proxy_http_version          => $proxy_http_version,
      proxy_set_header            => $proxy_set_header,
      proxy_hide_header           => $proxy_hide_header,
      proxy_pass_header           => $proxy_pass_header,
      proxy_set_body              => $proxy_set_body,
      proxy_buffering             => $proxy_buffering,
      fastcgi                     => $fastcgi,
      fastcgi_params              => $fastcgi_params,
      fastcgi_script              => $fastcgi_script,
      uwsgi                       => $uwsgi,
      uwsgi_params                => $uwsgi_params,
      uwsgi_read_timeout          => $uwsgi_read_timeout,
      try_files                   => $try_files,
      www_root                    => $www_root,
      autoindex                   => $autoindex,
      index_files                 => $index_files,
      location_custom_cfg         => $location_custom_cfg,
      location_cfg_prepend        => $location_cfg_prepend,
      location_cfg_append         => $location_cfg_append,
      location_custom_cfg_prepend => $location_custom_cfg_prepend,
      location_custom_cfg_append  => $location_custom_cfg_append,
      rewrite_rules               => $rewrite_rules,
      raw_prepend                 => $location_raw_prepend,
      raw_append                  => $location_raw_append,
      notify                      => Class['nginx::service'],
    }
    $root = undef
  } else {
    $root = $www_root
  }

  if $fastcgi != undef and !defined(File[$fastcgi_params]) {
    file { $fastcgi_params:
      ensure  => present,
      mode    => '0770',
      content => template('nginx/vhost/fastcgi_params.erb'),
    }
  }

  if $uwsgi != undef and !defined(File[$uwsgi_params]) {
    file { $uwsgi_params:
      ensure  => present,
      mode    => '0660',
      content => template('nginx/vhost/uwsgi_params.erb'),
    }
  }

  if (($listen_port + 0) != ($ssl_port + 0)) {
    concat::fragment { "${name_sanitized}-header":
      target  => $config_file,
      content => template('nginx/vhost/vhost_header.erb'),
      order   => '001',
    }
  }

  # Create a proper file close stub.
  if (($listen_port + 0) != ($ssl_port + 0)) {
    concat::fragment { "${name_sanitized}-footer":
      target  => $config_file,
      content => template('nginx/vhost/vhost_footer.erb'),
      order   => '699',
    }
  }

  # Create SSL File Stubs if SSL is enabled
  if ($ssl == true) {
    # Access and error logs are named differently in ssl template

    concat::fragment { "${name_sanitized}-ssl-header":
      target  => $config_file,
      content => template('nginx/vhost/vhost_ssl_header.erb'),
      order   => '700',
    }
    concat::fragment { "${name_sanitized}-ssl-footer":
      target  => $config_file,
      content => template('nginx/vhost/vhost_ssl_footer.erb'),
      order   => '999',
    }
  }

  unless $::nginx::config::confd_only {
    file{ "${name_sanitized}.conf symlink":
      ensure  => $vhost_symlink_ensure,
      path    => "${vhost_enable_dir}/${name_sanitized}.conf",
      target  => $config_file,
      require => [File[$vhost_dir], File[$vhost_enable_dir], Concat[$config_file]],
      notify  => Class['::nginx::service'],
    }
  }

  create_resources('::nginx::resource::map', $string_mappings)
  create_resources('::nginx::resource::geo', $geo_mappings)
  create_resources('::nginx::resource::location', $locations, {
    ensure   => $ensure,
    vhost    => $name_sanitized,
    ssl      => $ssl,
    ssl_only => $ssl_only,
    www_root => $www_root,
  })
}