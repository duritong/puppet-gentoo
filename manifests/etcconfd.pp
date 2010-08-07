define gentoo::etcconfd (){
    file { "/etc/conf.d/${name}":
        source => [
            "puppet:///modules/site-gentoo/etc_conf.d/${name}_${fqdn}",
            "puppet:///modules/site-gentoo/etc_conf.d/${name}_default",
            "puppet:///modules/gentoo/etc_conf.d/${name}"
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
