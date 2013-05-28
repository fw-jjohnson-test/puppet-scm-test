class java::jdk_solaris_uninstall (package_names) {
	package { "uninstall_${package_names}": ensure => 'absent' } -> 
	Class['java::jdk_solaris_uninstall']
}