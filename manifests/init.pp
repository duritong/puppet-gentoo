# modules/gentoo/manifests/init.pp - manage gentoo stuff
# Copyright (C) 2007 admin@immerda.ch
#

class gentoo {
    file {'/etc/portage/package.use':
        source => [
            "puppet:///modules/site-gentoo/package_use/$fqdn",
            "puppet:///modules/site-gentoo/package_use/default",
            "puppet:///modules/gentoo/package_use/$fqdn",
            "puppet:///modules/gentoo/package_use/default"
        ],
        owner => root, group => 0, mode  => 0644;
    }

    file {'/etc/portage/package.keywords':
        source => [
            "puppet:///modules/site-gentoo/package_keywords/$fqdn",
            "puppet:///modules/site-gentoo/package_keywords/default",
            "puppet:///modules/gentoo/package_keywords/$fqdn",
            "puppet:///modules/gentoo/package_keywords/default"
        ],
        owner => root, group => 0, mode  => 0644;
    }

    file {'/etc/portage/package.mask':
        source => [
            "puppet:///modules/site-gentoo/package_mask/$fqdn",
            "puppet:///modules/site-gentoo/package_mask/default",
            "puppet:///modules/gentoo/package_mask/$fqdn",
            "puppet:///modules/gentoo/package_mask/default"
        ],
        owner => root, group => 0, mode  => 0644;
    }
}
