node default {
    include jenkins
    install-jenkins-plugin {
        "git-plugin" :
            name => "git",
            require => Class["jenkins::package"],
            notify => Class["jenkins::service"],
    }

    include nginx
    nginx::resource::vhost { 
        "_" : 
	    ensure => present, 
	    proxy => "http://127.0.0.1:8080/",
            require => Class["jenkins::service"],
    } 
}
