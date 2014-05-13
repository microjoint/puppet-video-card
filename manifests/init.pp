class video-card (
    $controller     = 'vesa',
    $install_32bit  = false,
    $open_source    = true,
    $package_ensure = 'latest',
){
    case $open_source {
        true: {
            case $controller {
                'vesa':     { $package_name = 'xf86-video-vesa' }
                'intel':    { $package_name = 'xf86-video-intel' }
                'nvidia':   { $package_name = 'xf86-video-nvidia' }
                'ati':      { $package_name = 'xf86-video-ati' }
                'via':      { $package_name = 'xf86-video-openchrome' }
            }
            package { 'video-card':
              ensure => $package_ensure,
              name   => $package_name,
            }

            if $install_32bit == 'true' {
                case $controller {
                    'intel':    { $package32_name = 'lib32-nouveau-dri' }
                    'nvidia':   { $package32_name = 'lib32-intel-dri' }
                    'ati':      { $package32_name = 'lib32-ati-dri' }
                }
                if $package32_name {
                    package { 'video_card':
                        ensure => $package_ensure,
                        name   => $package32_name,
                    }
                }
            }
        }
        false: {
            case $controller {
                'ati':      { $package_name = 'catalyst-dkms' }
                'intel':    { $package_name = 'xf86-video-intel' }
                'nvidia':   { $package_name = 'nvidia' }
                'vesa':     { $package_name = 'xf86-video-vesa' }
            }
            package { 'video-card':
              ensure => $package_ensure,
              name   => $package_name,
            }

            if $install_32bit == 'true' {
                case $controller {
                    'ati':      { $package32_name = 'lib32-catalyst-utils' }
                    'intel':    { $package32_name = 'lib32-intel-dri' }
                    'nvidia':   { $package32_name = 'lib32-nvidia-utils' }
                }
                if $package32_name {
                    package { 'video_card':
                        ensure => $package_ensure,
                        name   => $package32_name,
                    }
                }
            }
        }
    }
}
