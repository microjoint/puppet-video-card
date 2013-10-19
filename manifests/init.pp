class video-card (
    $controller     = 'vesa',
    $install_32bit  = false,
    $open_source    = true,
){
    case $open_source {
        'true': {
            case $controller {
                'vesa':     { $package_name = 'xf86-video-vesa' }
                'intel':    { $package_name = 'xf86-video-intel' }
                'nvidia':   { $package_name = 'xf86-video-nvidia' }
                'ati':      { $package_name = 'xf86-video-ati' }
            }
            package { $package_name: ensure => present }

            if $install_32bit == 'true' {
                case $controller {
                    'intel':    { $package32_name = 'lib32-nouveau-dri' }
                    'nvidia':   { $package32_name = 'lib32-intel-dri' }
                    'ati':      { $package32_name = 'lib32-ati-dri' }
                }
                if $package32_name {
                    package { $package32_name: ensure => present }
                }
            }
        }
        'false': {
            case $controller {
                'ati':      { $package_name = 'catalyst-dkms' }
                'intel':    { $package_name = 'xf86-video-intel' }
                'nvidia':   { $package_name = 'nvidia' }
                'vesa':     { $package_name = 'xf86-video-vesa' }
            }
            package { $package_name: ensure => present }

            if $install_32bit == 'true' {
                case $controller {
                    'ati':      { $package32_name = 'lib32-catalyst-utils' }
                    'intel':    { $package32_name = 'lib32-intel-dri' }
                    'nvidia':   { $package32_name = 'lib32-nvidia-utils' }
                }
                if $package32_name {
                    package { $package32_name: ensure => present }
                }
            }
        }
    }
}
