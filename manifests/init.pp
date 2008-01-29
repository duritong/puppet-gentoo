# modules/gentoo/manifests/init.pp - manage gentoo stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "gentoo": }

class gentoo {

}

class gentoo::package_use {
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
}

class gentoo::package_keywords {
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
}

class gentoo::package_mask {
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
