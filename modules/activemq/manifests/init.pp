# == Class: activemq
#
# Perform a binary install of ActiveMQ on a CentOS server.
#
# === Parameters
# [*version*]
#  The version of ActiveMQ to install.
#  Default value is "5.6.0".
#
# [*base_url*]
#  The URL where the ActiveMQ tarball resides.  This URL will be used
#  by wget to fetch the tarball for installation.
#  default value is http://apache.mirrors.pair.com/activemq/apache-activemq
#
# [*download_dir*]
#  The directory where wget should put the ActiveMQ tarball after fetching it
#  from the file_url.
#  Default value is "/tmp".
#
# [*install_dir*]
#  The directory where ActiveMQ should be extracted to.
#  Default value is "/opt/activemq".
#
class activemq (
	$version		= "5.6.0",
	$base_url		= "http://apache.mirrors.pair.com/activemq/apache-activemq",
	$download_dir	= "/opt/tmp",
	$install_dir	= "/opt/activemq"
) {
	# TODO:  Find a better way to get the value for the unzipped file name
	$tar_file_name		= "apache-activemq-${activemq::version}-bin.tar.gz"
	$full_url			= "${base_url}/${activemq::version}/${tar_file_name}"
	#$install_path		= "${activemq::install_dir}/apache-activemq-${version}"
	
	case $operatingsystem {
	 	'CentOS', 'RedHat': {
	 		$package_class = "activemq::package"
	 		$cmd_path = "/bin:/sbin/:/usr/bin:/usr/sbin"
	  	}
	  	'Solaris': {
	  		$package_class = "activemq::package_solaris"
	  		$cmd_path = "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin"
	  	}
 	}

 	# file { "${install_dir}":
 	# 	ensure 	=> directory
 	# }
 	# ->
	#class { "activemq::get_source": }
	#->
	class { "${activemq::package_class}": }
	->
	#class { "activemq::config": } 
	#~>
	#class { "activemq::service": } 
	#->
	Class["activemq"]
}
