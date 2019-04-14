# project name and programming language
project('com.github.bbuhler.hostsmanager', 'vala', 'c')

# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

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
    [
      'src/HostsManager.vala',
      'src/Services/HostsRegex.vala',
      'src/Services/HostsFile.vala',
      'src/Services/Config.vala',
      'src/Widgets/IconButton.vala',
      'src/Widgets/TreeView.vala'
    ],
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)

#Translate and install our .desktop file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.desktop.in'),
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

#Translate and install our .appdata file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.appdata.xml.in'),
    output: meson.project_name() + '.appdata.xml',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

#Translate and install polkit action file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.pkexec.policy.in'),
    output: meson.project_name() + '.pkexec.policy',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'polkit-1/actions'),
    data_dirs: join_paths(meson.source_root(), 'gettext')
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

subdir('po')