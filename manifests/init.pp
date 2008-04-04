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
            "puppet://$server/files/gentoo/package_use/$fqdn",
            "puppet://$server/files/gentoo/package_use/default"
        ]
    }

    file { '/etc/portage/package.keywords':
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$server/files/gentoo/package_keywords/$fqdn",
            "puppet://$server/files/gentoo/package_keywords/default"
        ]
    }

    file { '/etc/portage/package.mask':
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$server/files/gentoo/package_mask/$fqdn",
            "puppet://$server/files/gentoo/package_mask/default"
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
        ensure => installed,
        category => $operatingsystem ? {
            gentoo => "${real_portagelocation}",
            default => '',
        },
    }
}

define gentoo::deploymakeconf ($templatepath){
    file {'host_makeconf':
        path => '/etc/make.conf',
        owner => root,
        group => 0,
        mode => 600,
        content => template("$templatepath"),
   }
}

define gentoo::etcconfd (){
    file { "/etc/conf.d/${name}":
        owner => "root",
        group => "0",
        mode  => 644,
        source => [
            "puppet://$server/files/gentoo/etc_conf.d/${name}_${fqdn}",
            "puppet://$server/files/gentoo/etc_conf.d/${name}_default",
            "puppet://$server/gentoo/etc_conf.d/${name}"
        ],
    }
    if $require {
        File["/etc/conf.d/${name}"]{
            require => $require,
        }
    }
    if $notify {
        File["/etc/conf.d/${name}"]{
            notify => $notify,
        }
    }
}
