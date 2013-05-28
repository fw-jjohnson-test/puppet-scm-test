# == Class: activemq::config
#
# Deploy the ActiveMQ file (which is configured for MCollective's stomp server
# requirements) and notify the ActivMQ service that the config file has changed (which
# will cause a restart of ActiveMQ).
#
# === Parameters
# [*install_dir*]
#  The directory in which ActiveMQ is installed/deployed.
#
class activemq::config {
	file { "${activemq::install_path}/conf/activemq.xml":
		ensure			=> file,
		source			=> "puppet:///modules/activemq/activemq.xml",
		#notify			=> Class["activemq::service"],
	}
}
