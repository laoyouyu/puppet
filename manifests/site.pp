node 'instance-1.c.master-reactor-187303.internal' { 
#  file { '/info.txt':
#   ensure => 'present',
#   content => inline_template("Create by Puppet at <%= Time.now %>\n"),
# }
##  $wikisitename = 'wiki'
##  $wikimetanamespace = 'Wiki'
##  $wikiserver = "http://10.152.0.3"
##  class { 'linux': }
##  class { 'mediawik': }
  hiera_include('classes', undef)
}
node 'puppetmaster.c.master-reactor-187303.internal' {

##  $wikisitename = 'wiki'
##  $wikimetanamespace = 'Wiki'
##  $wikiserver = "http://10.152.0.2"
##  class { 'linux': }
##  class { 'mediawiki': }
  hiera_include('classes', undef)
##  lookup('classes').include
}
node 'win-1.c.master-reactor-187303.internal' {
  hiera_include('classes',undef)
}
class linux {
  $admintool = [ 'git', 'nano', 'screen' ]
  package { $admintool:
	ensure => 'installed',
  }
  $telnetserver = $osfamily ? {
    'redhat' => 'telnet.socket',
    'debian' => 'telnetd',
    default => 'telnet.oscket'
  }
  vcsrepo {'/var/www/html':
    ensure => 'present',
    provider => 'git',
    source => "https://github.com/wikimedia/mediawiki.git",
    revision => "REL1_23",
  }
  service { $telnetserver:
    ensure => 'running', 
    enable => true
  }
  package { 'telnet-server':
    ensure => 'installed', 
  }
  Package['telnet-server'] -> Service[$telnetserver]
  Service[$telnetserver] -> Vcsrepo['/var/www/html']
  node default {
    accounts::user {'test':}
  }
  accounts::user {'test':
    group => 'jchen', 
    home => '/home/test',
    sshkeys => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBl+qzUyBnP3lhfs/z7EsohkxSHAcrRuZhDI/6+v/et6FHOvrrJCoH2J+jqsnABeQ0+r/E0bFJvOndC7bvx2KNW8LH2Dcxbup1K4wCZ5upWWSXnKyJ5TYxzwtiYGXfSRbNPaYQeiUAhc8yr9YHOS5P6L9kl23WHkUDIpSFZGvmQUs1MSonf46y8iJNief6BgVmsb/reso1Pal4XF+LF6MAT0Rz8rtou13u3Ng3IdFDRscHtH+ob1aIv02zLVV5kbWe1iEmttIRPkDv1UvleL4LcQfrWVpMMNvnRV2E1rGHhTmXd/Tltaz3MSOIAX2FCZVkL9Y0Mf/Fe3TR02s3+WOt test' ],
  }
  class { '::mysql::server':
    root_password => 'training',
  }
}
class windows {
  service { 'vds':
    ensure => 'running', 
    enable => 'true', 
  }
}

