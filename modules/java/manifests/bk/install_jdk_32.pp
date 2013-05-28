class java::jdk_solaris::install_jdk_32 inherits java::jdk_solaris {
	# Copy the jdk zip files from the puppet master to /tmp.
	#notify { "INSTALL:  checking for files...": }
    file {
    	"/tmp/${java::jdk_solaris::zip_file_name_32}":
    	ensure 	=> file,
    	source	=> "puppet:///modules/java/${java::jdk_solaris::zip_file_name_32}";

#		"/tmp/${zip_file_name_64}":
 #       ensure  => file,
  #      source  => "puppet:///modules/java/${zip_file_name_64}";
   
   		"/tmp/${java::jdk_solaris::admin_file}":
        ensure  => file,
        source  => "puppet:///modules/java/${java::jdk_solaris::admin_file}";
   }

   #notify { "INSTALL: zcatting the .tar.Z file...": }
	exec { "zcat_32":
		cwd		=> '/tmp',
		command	=> "zcat ${java::jdk_solaris::zip_file_name_32} | tar -xf -",
		creates	=> [
			'/tmp/SUNWj6cfg',
			'/tmp/SUNWj6dev', 
			'/tmp/SUNWj6jmp', 
			'/tmp/SUNWj6man',
			'/tmp/SUNWj6rt', 
			'/tmp/SUNWjavadb-javadoc', 
			'/tmp/SUNWjavadb-service', 
			'/tmp/SUNWjavadb-client', 
			'/tmp/SUNWjavadb-common', 
			'/tmp/SUNWjavadb-core', 
			'/tmp/SUNWjavadb-demo', 
			'/tmp/SUNWjavadb-docs' 
		],
		path	=> '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/opt/csw/sbin',
		#require => File["/tmp/${java::jdk_solaris::zip_file_name_32}"],
	}

	package { $java::jdk_solaris::java_packages:,
		ensure 		=> installed,
		source		=> "/tmp",
		adminfile 	=> "/tmp/${admin_file}",
		require 	=> Exec["zcat_32"],
	}

	# Package[$java::jdk_solaris::java_packages] {
	# 	source		=> "/tmp",
	# 	adminfile 	=> "/tmp/${admin_file}",
	# 	# require		=> [ 
	# 	# 	File[
	# 	# 		# '/tmp/SUNWj6cfg',
	# 	# 		# '/tmp/SUNWj6dev', 
	# 	# 		# '/tmp/SUNWj6jmp', 
	# 	# 		# '/tmp/SUNWj6man',
	# 	# 		# '/tmp/SUNWj6rt', 
	# 	# 		# '/tmp/SUNWjavadb-javadoc', 
	# 	# 		# '/tmp/SUNWjavadb-service', 
	# 	# 		# '/tmp/SUNWjavadb-client', 
	# 	# 		# '/tmp/SUNWjavadb-common', 
	# 	# 		# '/tmp/SUNWjavadb-core', 
	# 	# 		# '/tmp/SUNWjavadb-demo', 
	# 	# 		# '/tmp/SUNWjavadb-docs',
	# 	# 		# "/tmp/${admin_file}",
	# 	# 		# "/tmp/${zip_file_name_32}",
	# 	# 		"/tmp/${admin_file}"
	# 	# 	],
	# 	require	=> Exec["zcat_32"], 
	# 	#],
	# }

	# realize Package[$java::jdk_solaris::java_packages]
}