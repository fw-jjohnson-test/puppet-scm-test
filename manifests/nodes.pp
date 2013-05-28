node "activemq.example.com" {
        notify { 'alpha': }
#        ->
#        class {'wget': }
#        ->
#       class {'pkgutil': }
#       ->
        class { 'rubygems': }
        ->
#        class  { 'java':
#                distribution    => 'jdk',
#                version         => '6',
#                update          => '43',
#        }
#        ->
#        class { 'stomp': }
#        ->
        class  { 'activemq': }
        ->
        notify { 'omega': }
}
node "puppet-master.example.com" {
#        class{ 'stomp': }
	class { "java":
		distribution	=> "jdk",
		version		=> "6",
		update		=> "43",
	}
}

node /web\d+\.example\.com/ {
        #class { 'wget': }
        #->
        class { 'java':
                distribution    => 'jdk',
                version         => '6',
                update          => '43',
        }
}
