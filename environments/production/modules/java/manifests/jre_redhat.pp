# == Class: java::jre
#
# Installs java-[specified version]-openjdk on a CentOS server.
# Since java version 1.6.0 and 6 are synonymous, we only ask the
# user for the "shorter" version number (i.e. the "6" or the "7") and
# the class takes care of building the "full" version number.
#
# === Parameters
# [*version*]
# The "short" version of Java that should be installed.
#
class java::jre_redhat ($version) {
        $full_version = "1.${version}.0"
        $package_name = "java-${full_version}-openjdk"

        package { 'jre':
                ensure  => installed,
                name    => $package_name,
        }
}