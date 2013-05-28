class rubygems {
	package { "CSWrubygems":
		ensure		=> installed,
		provider	=> pkgutil,
	}
}