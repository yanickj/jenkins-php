class jenkins-php {
    include php
    include jenkins

    service { "iptables":
        ensure => "stopped",
        enable => false,
    }

    php::pear::module { 'phpqatools':
        repository  => 'pear.phpqatools.org',
        use_package => 'no',
        timeout     => 0,
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