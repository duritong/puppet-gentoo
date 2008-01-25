# modules/gentoo/manifests/init.pp - manage gentoo stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "gentoo": }

class gentoo {

}

class gentoo::package_use {
    file { '/usr/portage/package.use':
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
