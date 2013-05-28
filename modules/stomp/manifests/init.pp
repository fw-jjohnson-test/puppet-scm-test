class stomp {
	package { 'stomp':
		ensure		=> 'installed',
		provider	=> 'gem',
	}
}
