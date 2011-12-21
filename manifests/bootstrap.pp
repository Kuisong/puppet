class git {
    package { 'git-core':
        ensure => installed,
    }
}

node default {
    include git

    exec {
        "clone git repository":
        cwd => "/home/ubuntu",
        user => "ubuntu",
        command => '/usr/bin/git clone http://github.com/Kuisong/puppet puppet',
        require => Class["git"]
    }

    exec {
        "checkout git branch":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => '/usr/bin/git checkout $environment',
        require => Class["git"]
    }

    exec {
        "update git submodule":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => '/usr/bin/git submodule update --init',
        require => Class["git"]
    }

    exec {
        "apply puppet configuration":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => 'sudo /usr/bin/puppet apply --modulepath=modules manifests/$manifest',
    }
}
