# Class: mediawiki
# ===========================
#
# Full description of class mediawiki here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mediawiki':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class mediawiki {
  
  $wikimetanamespace = hiera('mediawiki::wikimetanamespace')
  $wikisitename      = hiera('mediawiki::wikisitename')
  $wikiserver        = hiera('mediawiki::wikiserver')

  $phpmysql = $osfamily ? {
    'redhat' => 'php-mysql',
    'debian' => 'php5-mysql',
    default => 'php-mysql',
  }
  
  package { $phpmysql:
    ensure => 'present',
  }
  if $osfamily == 'redhat' {
    package { 'php-xml': 
    ensure => 'present',
    }
  }
  class { '::apache':
    docroot => '/var/www/html',
    mpm_module => 'prefork',
    subscribe => Package[$phpmysql],
  }
  class { '::apache::mod::php':}

  file { 'LocalSettings.php':
    path    => '/var/www/html/LocalSettings.php',
    ensure  => 'file',
    content => template('mediawiki/LocalSettings.erb'),
  }
}
