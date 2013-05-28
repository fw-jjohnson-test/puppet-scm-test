class utils::solaris($tmp_dir = "/opt/tmp") {
	define remove_solaris_package($pkg_admin_file) {
		exec { "uninstall_${name}":
			command 	=> "pkgrm -n -v -a ${pkg_admin_file} ${name}",
			logoutput	=> on_failure,
			onlyif		=> "test `pkginfo -x | grep -w ${name} | awk 'END{print NR \"\"}'` -eq 1",
			path		=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
			require		=> File["${pkg_admin_file}"],
		}
	}
}