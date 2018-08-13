# project name and programming language
project('com.github.bbuhler.HostsManager', 'vala', 'c')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/HostsManager-pkexec.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)
executable(
    meson.project_name() + '.main',
    'src/HostsManager.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)

#Install our .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', meson.project_name() + '.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications')
)

#Install our .appdata.xml file so AppCenter will see it
install_data(
    join_paths('data', meson.project_name() + '.appdata.xml'),
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

#Install polkit action file
install_data(
    join_paths('data', meson.project_name() + '.pkexec.policy'),
    install_dir: join_paths(get_option('datadir'), 'polkit-1/actions')
)

#Install icons
install_data(
    join_paths('data/icons/16', meson.project_name() + '.svg'),
    join_paths('data/icons/16', meson.project_name() + '.png'),
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/16x16/apps')
)
install_data(
    join_paths('data/icons/32', meson.project_name() + '.svg'),
    join_paths('data/icons/32', meson.project_name() + '.png'),
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/32x32/apps')
)
install_data(
    join_paths('data/icons/48', meson.project_name() + '.svg'),
    join_paths('data/icons/48', meson.project_name() + '.png'),
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/48x48/apps')
)
install_data(
    join_paths('data/icons/64', meson.project_name() + '.png'),
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/64x64/apps')
)
install_data(
    join_paths('data/icons/128', meson.project_name() + '.svg'),
    join_paths('data/icons/128', meson.project_name() + '.png'),
    install_dir: join_paths(get_option('datadir'), 'icons/hicolor/128x128/apps')
)