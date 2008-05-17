# modules/gentoo/manifests/init.pp - manage gentoo stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "gentoo": }

class gentoo {
    file {'/etc/portage/package.use':
        source => [
            "puppet://$server/files/gentoo/package_use/$fqdn",
            "puppet://$server/files/gentoo/package_use/default",
            "puppet://$server/gentoo/package_use/$fqdn",
            "puppet://$server/gentoo/package_use/default"
        ],
        owner => root, group => 0, mode  => 0644;
    }

    file {'/etc/portage/package.keywords':
        source => [
            "puppet://$server/files/gentoo/package_keywords/$fqdn",
            "puppet://$server/files/gentoo/package_keywords/default",
            "puppet://$server/gentoo/package_keywords/$fqdn",
            "puppet://$server/gentoo/package_keywords/default"
        ],
        owner => root, group => 0, mode  => 0644;
    }

    file {'/etc/portage/package.mask':
        source => [
            "puppet://$server/files/gentoo/package_mask/$fqdn",
            "puppet://$server/files/gentoo/package_mask/default",
            "puppet://$server/gentoo/package_mask/$fqdn",
            "puppet://$server/gentoo/package_mask/default"
        ],
        owner => root, group => 0, mode  => 0644;
    }
}

define gentoo::deploymakeconf ($templatepath){
    file {'/etc/make.conf':
        content => template("$templatepath"),
        owner => root, group => 0, mode => 0600;
   }
}

define gentoo::etcconfd (){
    file { "/etc/conf.d/${name}":
        source => [
            "puppet://$server/files/gentoo/etc_conf.d/${name}_${fqdn}",
            "puppet://$server/files/gentoo/etc_conf.d/${name}_default",
            "puppet://$server/gentoo/etc_conf.d/${name}"
        ],
        owner => root, group => 0, mode  => 0644;
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
