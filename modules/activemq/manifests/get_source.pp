class activemq::get_source {
		# Use wget to fetch the tarball from the specified url.
	exec { "get ${activemq::tar_file_name}":
		cwd			=> "${activemq::download_dir}",
		command		=> "wget ${activemq::full_url}",
		creates		=> "${activemq::download_dir}/${activemq::tar_file_name}",
		logoutput	=> on_failure,
		path		=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
	}
}