# This module should not be used directly. It is used by newrelic::php.
define newrelic::php::newrelic_ini (
  $newrelic_license_key,
  $newrelic_ini_appname,
  $newrelic_ini_browser_monitoring_auto_instrument       = undef,
  $newrelic_ini_capture_params                           = undef,
  $newrelic_ini_distributed_tracing_enabled              = undef,
  $newrelic_ini_enabled                                  = undef,
  $newrelic_ini_error_collector_enabled                  = undef,
  $newrelic_ini_error_collector_prioritize_api_errors    = undef,
  $newrelic_ini_error_collector_record_database_errors   = undef,
  $newrelic_ini_framework                                = undef,
  $newrelic_ini_high_security                            = undef,
  $newrelic_ini_ignored_params                           = undef,
  $newrelic_ini_logfile                                  = undef,
  $newrelic_ini_loglevel                                 = undef,
  $newrelic_ini_transaction_tracer_custom                = undef,
  $newrelic_ini_transaction_tracer_detail                = undef,
  $newrelic_ini_transaction_tracer_enabled               = undef,
  $newrelic_ini_transaction_tracer_explain_enabled       = undef,
  $newrelic_ini_transaction_tracer_explain_threshold     = undef,
  $newrelic_ini_transaction_tracer_record_sql            = undef,
  $newrelic_ini_transaction_tracer_slow_sql              = undef,
  $newrelic_ini_transaction_tracer_stack_trace_threshold = undef,
  $newrelic_ini_transaction_tracer_threshold             = undef,
  $newrelic_ini_webtransaction_name_files                = undef,
  $newrelic_daemon_cfgfile_ensure                        = undef,
  $newrelic_daemon_dont_launch                           = undef,
  $newrelic_daemon_pidfile                               = undef,
  $newrelic_daemon_location                              = undef,
  $newrelic_daemon_logfile                               = undef,
  $newrelic_daemon_loglevel                              = undef,
  $newrelic_daemon_port                                  = undef,
  $newrelic_daemon_ssl                                   = undef,
  $newrelic_daemon_ssl_ca_bundle                         = undef,
  $newrelic_daemon_ssl_ca_path                           = undef,
  $newrelic_daemon_proxy                                 = undef,
  $newrelic_daemon_collector_host                        = undef,
  $newrelic_daemon_auditlog                              = undef,
  $newrelic_hostname                                     = undef,
  $exec_path,
) {

  exec { "/usr/bin/newrelic-install ${name}":
    path     => $exec_path,
    command  => "/usr/bin/newrelic-install purge ; NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${newrelic_license_key} /usr/bin/newrelic-install install",
    provider => 'shell',
    user     => 'root',
    group    => 'root',
    unless   => "grep ${newrelic_license_key} ${name}/newrelic.ini",
  }

  file { "${name}/newrelic.ini":
    path    => "${name}/newrelic.ini",
    content => template('newrelic/newrelic.ini.erb'),
    require => Exec["/usr/bin/newrelic-install ${name}"],
  }

}
