class wget {
	# define remove_wget_package() {
	# 	exec { "uninstall_${name}":
	# 		cwd			=> "/opt/tmp",
	# 		command 	=> "pkgrm -n -a java_admin CSWwget",
	# 		onlyif		=> "test `pkginfo -x | grep -w ${name} | awk 'END{print NR \"\"}' 2>&1` -eq 1 && test `pkginfo -x | grep -w ${name} | awk '{print \$1}'` = ${name}",
	# 		path		=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
	# 	}
	# }

	# remove_wget_package { "CSWwget": }
	# ->
	package { "CSWwget":
		ensure	=> latest,
		provider => pkgutil,
	}
}
