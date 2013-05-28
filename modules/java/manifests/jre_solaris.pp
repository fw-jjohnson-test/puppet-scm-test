# == Class: java::jdk
#
# Installs java-[specified version]-openjdk-devel on a Solaris 10 server.
# Since java version 1.6.0 and 6 are synonymous, we only ask the
# user for the "shorter" version number (i.e. the "6" or the "7") and
# the class takes care of building the "full" version number.
#
# === Parameters
# [*version*]
# The "short" version of Java that should be installed.
#
class java::jre_solaris ($version,
						 $update
) {
        $package_name = "jre-${version}u${update}-solaris-x64.sh"

        package { 'jre':
                ensure  => installed,
                name    => $package_name,
                source	=> "puppet:///modules/java/${package_name}",
        }
}