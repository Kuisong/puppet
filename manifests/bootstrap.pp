class git {
     package { 'git':
         ensure => installed,
     }
}

node default {
    include git

    exec {
        "clone":
        cwd => "/home/ubuntu",
        user => "ubuntu",
        command => '/usr/bin/git clone http://github.com/Kuisong/puppet puppet',
        require => Class["git"]
    }

    exec {
        "checkout":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => '/usr/bin/git checkout master',
        require => Exec["clone"]
    }

    exec {
        "update submodule":
        cwd => "/home/ubuntu/puppet",
        user => "ubuntu",
        command => '/usr/bin/git submodule update --init',
        require => Exec["checkout"],
    }

    exec {
        "apply puppet":
        cwd => "/home/ubuntu",
        user => "root",
        command => "/usr/bin/puppet apply --modulepath=/home/ubuntu/puppet/modules /home/ubuntu/puppet/manifests/ci.pp",
        require => Exec["update submodule"],
    }
}
