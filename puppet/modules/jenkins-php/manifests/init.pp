class jenkins-php {
    include php
    include jenkins

    service { "iptables":
        ensure => "stopped",
        enable => false,
    }

    exec { 'pear-auto-discover':
        path    => '/usr/bin:/usr/sbin:/bin',
        onlyif  => 'test "`pear config-get auto_discover`" = "0"',
        command => 'pear config-set auto_discover 1 system',
        require => Class['php'],
    }

    exec { 'install-phpqatools':
        unless => '/usr/bin/pear info pear.phpqatools.org/phpqatools',
        command => '/usr/bin/pear install pear.phpqatools.org/phpqatools',
        timeout => 0,
        require => [Class['php'], Exec['pear-auto-discover']],
    }

    package { "php-xml":
        ensure  => present,
        require => Package['php'],
    }

    package { "ant":
        ensure => present,
    }

    jenkins::plugin { "git": }
    jenkins::plugin { "checkstyle": }
    jenkins::plugin { "cloverphp": }
    jenkins::plugin { "dry": }
    jenkins::plugin { "htmlpublisher": }
    jenkins::plugin { "jdepend": }
    jenkins::plugin { "plot": }
    jenkins::plugin { "pmd": }
    jenkins::plugin { "violations": }
    jenkins::plugin { "xunit": }
}