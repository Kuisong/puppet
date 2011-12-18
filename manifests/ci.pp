node default {
    include jenkins
    install-jenkins-plugin {
        "git-plugin" :
            name => "git";
    }

    include nginx
    nginx::resource::vhost { $host : ensure => present, proxy => 'http://127.0.0
.1:8080/', } 
}
