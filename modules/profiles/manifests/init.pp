# Class: profiles
# ===========================
#
# Full description of class profiles here.
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
#    class { 'profiles':
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
class profiles {


}
class profiles::windows::mysqlwk{
  file { 'c:/temp/':
   ensure => 'directory',
  }

  download_file {"Microsoft Visual C++ 2013 Redistributable(x86) -12.0.30501":
   url  => 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe',
   destination_directory => 'c:\temp',
  }

  package { "Microsoft Visual C++ 2013 Redistributable(x86) -12.0.30501":
   ensure => 'installed',
   source => 'c:\temp\vcredist_x64.exe',
   install_options => [ '/quiet' ],
  }

  download_file {"Microsoft .NET Framework 4 Client Profile":
   url  => 'http://download.microsoft.com/download/5/6/2/562A10F9-C9F4-4313-A044-9C94E0A8FAC8/dotNetFx40_Client_x86_x64.exe',
   destination_directory =>'c:\temp',
  }
  package { "Microsoft .NET Framework 4 Client Profile":
   ensure => 'installed',
   source => 'c:\temp\dotNetFx40_Client_x86_x64.exe',
   install_options => [ '/q'],
  }

 download_file {"MySQL Workbench 6.2 CE":
   url  => 'http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.2.4-winx64.msi',
   destination_directory =>'c:\temp',
  }
  package { "MySQL Workbench 6.2 CE":
   ensure => 'installed',
   source => 'c:\temp\mysql-workbench-community-6.2.4-winx64.msi',
  }
}
class profiles::windows::putty {
  file { 'c:/admintools/':
   ensure => 'directory',
  }
  download_file {"Download putty":
    url   => 'http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe',
    destination_directory =>'c:/admintools',
  }
} 

