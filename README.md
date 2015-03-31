Minimal Setup for BaseX Web Applications
========================================

This is the minimal necessary setup for a BaseX Web Application.

It contains the files as follows:

	├── data ............. database storage
	├── pom.xml .......... application configuration
	├── repo ............. XQuery library modules
	├── restxq ........... RESTXQ handlers
	├── static ........... static content, i.e. images, js, css
	└── WEB-INF
	    └── web.xml ...... service configuration, i.e. (de)activate REST, RESTXQ, WebDAV


Run this basic Web Application from the console via `mvn jetty:run`. For other possibilities refer to the documentation of [BaseX Web Applications](http://docs.basex.org/wiki/Web_Application).

For further details the [BaseX documentation](http://docs.basex.org/wiki/Main_Page) will help you.