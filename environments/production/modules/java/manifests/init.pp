# == Class: java
#
# This class will install the java openjdk and java openjdk-devel on a CentOS server.
# The yum provider will be used to handle the installation.
#
# === Parameters
#
# [*distribution*]
#	The type of package to install, either 'jdk' or 'jre'.
#
# [*version*]
#	The single-digit version of Java (e.g. 6 or 7) that should be installed.
#
# [*update*]
#	The update version of the JDK or JRE that should be installed.
#
# === Example
#
# Shown below is an example of how to use the java class to install the JDK and JDK-devel
# packages on a node called "activemq.example.com":
#
# node "activemq.example.com" {
#        class  { 'java':
#					distribution	=> 'jdk',
#                	version 		=> '6',
#					update			=> '25',
#        }
# }
class java ($distribution, 
			$version, 
			$update
) {
	$class_prefix = $distribution ? { 
		jdk => 'java::jdk',
		jre => 'java::jre',
	 }

	case $::operatingsystem {
		'RedHat', 'CentOS': {
        	class { "${java::class_prefix}_redhat": 
        		version => "${java::version}" 
        	} 
        	->
        	Class["java"]
    	}

    	'Solaris': {

    		class { "${java::class_prefix}_solaris": 
    			version	=> "${java::version}", 
    			update	=> "${java::update}",
    		} 
            ->
            Class["java"]
    	}
	}
}
