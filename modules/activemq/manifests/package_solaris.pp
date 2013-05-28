# == Class: activemq::package_solaris
#
# Installs ActiveMQ [specified version] on a Solaris 10 server.
#
# === Parameters
#
# [*version*]
#	The "short" version of Java that should be installed.
#
class activemq::package_solaris {
	# Set the defaults for the "exec" commands
	Exec {
		path	=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
	}

	exec { "get ${activemq::tar_file_name}":
		cwd			=> "${activemq::download_dir}",
		command		=> "wget ${activemq::full_url}",
		creates		=> "${activemq::download_dir}/${activemq::tar_file_name}",
		logoutput	=> on_failure,
	#	path		=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
	}

	file { "${activemq::install_dir}":
		ensure	=> directory,
	}

	# create the install directory (if it doesn't already exist) and
	# extract the tarball into it.
	exec { "untar ${activemq::unzipped_file_name}":
		cwd		=> "${activemq::download_dir}",
		command	=> "/usr/sfw/bin/gtar -xvzf ${activemq::tar_file_name} -C ${activemq::install_dir} --strip=1",
		require	=> File["${activemq::install_dir}"],	
	}

	# Deploy the ActiveMQ configuration file stored on the puppet master.
	file { "${activemq::install_dir}/conf/activemq.xml":
		ensure	=> file,
		source	=> "puppet:///modules/activemq/activemq.xml",
		require	=> Exec["untar ${activemq::unzipped_file_name}"],
		notify	=> Service["activemq svc"],
	}

	# Start the ActiveMQ service.
	service { "activemq svc":
		ensure		=> running,
		hasstatus	=> false,
		hasrestart	=> false,
		restart		=> "${activemq::install_dir}/bin/activemq restart",
		start		=> "${activemq::install_dir}/bin/activemq start",
		status		=> "${activemq::install_dir}/bin/activemq status",
		stop		=> "${activemq::install_dir}/bin/activemq stop",
		#require		=> Class["activemq::config"],
	}

	# remove the tar and tar.gz files.
	exec { "package_solaris_cleanup":
		cwd		=> "${activemq::download_dir}",
		command => "rm -r ${activemq::tar_file_name}",
		require => Service["activemq svc"],
	}
}