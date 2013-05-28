class activemq::service {
	service { 'activemq':
		ensure		=> running,
		enable		=> true,
		hasstatus	=> false,
		hasrestart	=> false,
		restart		=> "${activemq::install_dir}/bin/activemq restart",
		start		=> "${activemq::install_dir}/bin/activemq start",
		status		=> "${activemq::install_dir}/bin/activemq status",
		stop		=> "${activemq::install_dir}/bin/activemq stop",
		#require		=> Class["activemq::config"],
	}
}
