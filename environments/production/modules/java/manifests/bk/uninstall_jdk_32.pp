class java::jdk_solaris::uninstall_jdk_32 inherits java::jdk_solaris {
	# notify { "UNINSTALL: adjusting jdk package attributes...": }
	 Package[$java::jdk_solaris::java_packages] { 
	 	ensure	=> absent,
	 }

	# notify { "UNINSTALL: realizing Package...": }
	realize Package[$java::jdk_solaris::java_packages]
}