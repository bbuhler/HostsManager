# project name
project (HostsManager)

# uninstall target
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY)

add_custom_target(uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

# the oldest stable cmake version to require
cmake_minimum_required (VERSION 2.6)

# tell cmake where its modules can be found in our project directory (vala modules)
#list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
#list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/src)

# where we install data directory (if we have any)
set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

# what to call that directory where we install data too
set (PKGDATADIR "${DATADIR}/HostsManager")

#set the name of our two executables
set (EXEC_NAME "HostsManager-pkexec")
set (EXEC_NAME2 "HostsManager")
set (RELEASE_NAME "Manage your /etc/hosts file easily")
set (VERSION "0.1")
set (VERSION_INFO "First release")

# we're about to use pkgconfig to make sure dependencies are installed so let's find pkgconfig first
find_package(PkgConfig)

# now let's actually check for the required dependencies
pkg_check_modules(DEPS REQUIRED gtk+-3.0 gio-2.0)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

# make sure we have vala
find_package(Vala REQUIRED)
# make sure we use vala
include(ValaVersion)
# make sure it's the desired version of vala
ensure_vala_version("0.16" MINIMUM)

# files we want to compile
include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/HostsManager-pkexec.vala

# tell what libraries to use when compiling
PACKAGES
    gtk+-3.0
    gio-2.0
)

# tell cmake what to call the executable we just made
add_executable(${EXEC_NAME} ${VALA_C})
target_compile_options (${EXEC_NAME} PUBLIC -fPIE)

vala_precompile(VALA_C ${EXEC_NAME2}
    src/HostsManager.vala

# tell what libraries to use when compiling
PACKAGES
    gtk+-3.0
    gio-2.0
)
# tell cmake what to call the executable we just made
add_executable(${EXEC_NAME2} ${VALA_C})

# install the binaries we just made
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)
install (TARGETS ${EXEC_NAME2} RUNTIME DESTINATION bin)

# install the polkit action file
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/HostsManager.pkexec.policy DESTINATION /usr/share/polkit-1/actions/)

# install our .desktop file so the Applications menu will see it
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/HostsManager.desktop DESTINATION ${DATADIR}/applications/)

# install the application icons
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/16/HostsManager.png DESTINATION ${DATADIR}/icons/gnome/16x16/apps/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/24/HostsManager.png DESTINATION ${DATADIR}/icons/gnome/24x24/apps/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/32/HostsManager.png DESTINATION ${DATADIR}/icons/gnome/32x32/apps/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/48/HostsManager.png DESTINATION ${DATADIR}/icons/gnome/48x48/apps/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/128/HostsManager.png DESTINATION ${DATADIR}/icons/gnome/128x128/apps/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/128/HostsManager.svg DESTINATION ${DATADIR}/pixmaps/)

install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/16/HostsManager.svg DESTINATION ${DATADIR}/icons/elementary/apps/16/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/24/HostsManager.svg DESTINATION ${DATADIR}/icons/elementary/apps/24/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/32/HostsManager.svg DESTINATION ${DATADIR}/icons/elementary/apps/32/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/48/HostsManager.svg DESTINATION ${DATADIR}/icons/elementary/apps/48/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/128/HostsManager.svg DESTINATION ${DATADIR}/icons/elementary/apps/128/)
