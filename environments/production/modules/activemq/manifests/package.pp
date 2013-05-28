class activemq::package {
	# create the install directory (if it doesn't already exist) and
	# extract the tarball into it.
	exec { "extract ${activemq::tar_file_name}":
		cwd	=> "${activemq::download_dir}",
		command	=> "mkdir -p ${activemq::install_dir} && tar -zxvf ${activemq::tar_file_name} -C ${activemq::install_dir}",
		path	=> "${activemq::cmd_path}",
	}
}
