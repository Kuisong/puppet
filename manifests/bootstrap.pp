node default {
    include git   
    git-clone("http://github.com/Kuisong/puppet", $environment)
}

class git {
    package { 'git-core':
        ensure => installed,
    }
}

define puppet-apply($manifest) {
    exec {
        "apply puppet configuration":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => 'sudo /usr/bin/puppet apply --modulepath=modules $manifest',
    }
}

define git-clone($source, $branch="master") {
    exec {
        "clone git repository":
        cwd => "/home/ubuntu",
        user => "ubuntu",
        command => '/usr/bin/git clone $source puppet',
        require => Class["git"]
    }

    exec {
        "checkout git branch":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => '/usr/bin/git checkout $branch',
        require => Class["git"]
    }

    exec {
        "update git submodule":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => '/usr/bin/git submodule update --init',
        require => Class["git"]
    }
}
