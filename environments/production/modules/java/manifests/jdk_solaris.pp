# == Class: java::jdk
#
# Installs java [specified version] [specified update] JDK on a Solaris 10 server.
# Since java version 1.6.0 and 6 are synonymous, we only ask the
# user for the "shorter" version number (i.e. the "6" or the "7") and
# the class takes care of building the "full" version number.
#
# === Parameters
#
# [*version*]
#	The "short" version of Java that should be installed.
#
# [*update*]
#	The update version of Java that should be installed.
#
class java::jdk_solaris ($version,
                         $update
) {
	include utils::solaris

	$working_dir		= "/opt/tmp"
	$zip_file_name_32 	= "jdk-${version}u${update}-solaris-i586.tar.Z"
    $zip_file_name_64 	= "jdk-${version}u${update}-solaris-x64.tar.Z"
    $admin_file 		= "java_admin"
    $java_packages 		= [ "SUNWj6cfg", "SUNWj6dev", "SUNWj6jmp", "SUNWj6man", "SUNWj6rt" ]

	file { 
		"${java::jdk_solaris::working_dir}":
   		ensure 	=> directory;

		"${java::jdk_solaris::working_dir}/${java::jdk_solaris::zip_file_name_32}":
    	ensure 	=> file,
    	source	=> "puppet:///modules/java/${java::jdk_solaris::zip_file_name_32}";

    	"${java::jdk_solaris::working_dir}/${java::jdk_solaris::admin_file}":
		ensure 	=> file,
		source 	=> "puppet:///modules/java/${java::jdk_solaris::admin_file}";
   	}

	exec { "zcat_32":
		cwd		=> "${java::jdk_solaris::working_dir}",
		command	=> "zcat ${java::jdk_solaris::zip_file_name_32} | tar -xf -",
		creates	=> [
			"${java::jdk_solaris::working_dir}/SUNWj6cfg",
			"${java::jdk_solaris::working_dir}/SUNWj6dev", 
			"${java::jdk_solaris::working_dir}/SUNWj6jmp", 
			"${java::jdk_solaris::working_dir}/SUNWj6man",
			"${java::jdk_solaris::working_dir}/SUNWj6rt" 
		],
		path	=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
		require => File[
				"${java::jdk_solaris::working_dir}",
				"${java::jdk_solaris::working_dir}/${java::jdk_solaris::zip_file_name_32}"
			],
	}				   

#------------------------------------------------------------------------------------------------------------------------
# INSTALL JDK
#------------------------------------------------------------------------------------------------------------------------

	remove_solaris_package { $java_packages: 
		pkg_admin_file 	=> "${java::jdk_solaris::working_dir}/${java::jdk_solaris::admin_file}",
		require			=> Exec["zcat_32"],
	} 
	->
	package { $java_packages:
		ensure 		=> latest,
		adminfile 	=> "${java::jdk_solaris::working_dir}/${java::jdk_solaris::admin_file}",
		source		=> "${java::jdk_solaris::working_dir}",
	}

#------------------------------------------------------------------------------------------------------------------------
# CLEAN UP AFTER INSTALLATION
#------------------------------------------------------------------------------------------------------------------------

	exec { "jdk_solaris_cleanup":
		cwd 	=> "${java::jdk_solaris::working_dir}",
		command => "rm -r ${java::jdk_solaris::admin_file} SUNWj* THIRDPARTYLICENSEREADME.txt COPYRIGHT LICENSE README.html ${java::jdk_solaris::zip_file_name_32}",
		path	=> "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
		require => Package[$java_packages],
	}

#------------------------------------------------------------------------------------------------------------------------
# INSTALL 64-BIT EXTENSIONS
#------------------------------------------------------------------------------------------------------------------------
#    -> Apparently, the SUNWj6dmx package doesn"t exist in the java 6u43 jdk (even though the install docs say it does...)
#    package { "uninstall_SUNWj6dmx":
#        ensure          => absent,
#        name            => "SUNWj6dmx",
#        adminfile       => "${admin_file}",
#       require         => File["${admin_file}"],
#    }
    # Extract the jdk zip.
#    exec { "zcat_64":
#        cwd		=> "/tmp",
#        command	=> "zcat ${zip_file_name_64} | tar -xf -",
#        creates => ["/tmp/SUNWj6rtx", "/tmp/SUNWj6dvx"],
#        path    => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin",
#    }
#    ->
    # Ensure that the previous versions of the jdk packages have been removed
    # before re-installing them.
#    package { "unintsall_SUNWj6rtx":
#       ensure 		=> absent,
#        name 		=> "SUNWj6rtx",
#        adminfile 	=> "${admin_file}",
#        require 	=> File["${admin_file}"],
#    }
#    ->
#    package { "uninstall_SUNWj6dvx":
#        ensure 		=> absent,
#        name 		=> "SUNWj6dvx",
#        adminfile 	=> "${admin_file}",
#        require 	=> File["${admin_file}"],
#    }
#    ->
#    package { "SUNWj6rtx":
#        ensure 		=> installed,
#        source		=> "/tmp",
#        adminfile 	=> "${admin_file}",
#        require		=> File["${admin_file}"],
#    }
#    ->
#    package { "SUNWj6dvx":
#        ensure 		=> installed,
#        source 		=> "/tmp",
#        adminfile 	=> "${admin_file}",
#        require 	=> File["${admin_file}"],
#    }
}

