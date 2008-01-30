# modules/gentoo/manifests/init.pp - manage gentoo stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "gentoo": }

class gentoo {
    file { '/etc/portage/package.use':
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$servername/gentoo/package_use/$fqdn",
            "puppet://$servername/gentoo/package_use/default"
        ]
    }

    file { '/etc/portage/package.keywords':
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$servername/gentoo/package_keywords/$fqdn",
            "puppet://$servername/gentoo/package_keywords/default"
        ]
    }

    file { '/etc/portage/package.mask':
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$servername/gentoo/package_mask/$fqdn",
            "puppet://$servername/gentoo/package_mask/default"
        ]
    }
}

define gentoo::installselinuxpackage (
    $portagelocation = ''
) {

    $real_portagelocation = $portagelocation ? {
        ''      => 'sec-policy',
        default =>  $portagelocation,
    }

    package { "${name}":
        ensure => present,
        category => $operatingsystem ? {
            gentoo => "${real_portagelocation}",
            default => '',
        },
    }
}

define gentoo::deploymakeconf ($templatepath){
    file {'host_makeconf':
        path => '/etc/make.conf',
        ensure => file,
        owner => root,
        group => 0,
        mode => 600,
        content => template("$templatepath"),
   }
}
