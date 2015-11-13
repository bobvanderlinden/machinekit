cmake_minimum_required(VERSION 2.8)
project(MACHINEKIT)

set(MACHINEKIT_MAJOR_VERSION 0)
set(MACHINEKIT_MINOR_VERSION 1)
set(MACHINEKIT_PATCH_VERSION 0)
set(MACHINEKIT_VERSION ${MACHINEKIT_MAJOR_VERSION}.${MACHINEKIT_MINOR_VERSION}.${MACHINEKIT_PATCH_VERSION})

# CMake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

# CMake modules
# TODO: Remove unused ones.
include(CheckFunctionExists)
include(CheckIncludeFile)
include(CheckIncludeFiles)
include(CheckTypeSize)
include(CheckVariableExists)
include(CheckSymbolExists)
include(CheckStructHasMember)
include(CheckCSourceCompiles)
include(CheckPrototypeDefinition)
include(FindPkgConfig)
include(GNUInstallDirs)
include(FindReadline)
# From https://github.com/thewtex/cython-cmake-example:
include(UseCython)
include(UseHALComp)

# External packages
find_package(Boost COMPONENTS python REQUIRED)
find_package(PythonLibs 2.7 REQUIRED)
find_package(PythonInterp 2.7 REQUIRED)
find_package(Protobuf REQUIRED)
find_package(Threads REQUIRED)
find_package(Readline REQUIRED)
pkg_check_modules(JANSSON REQUIRED jansson)
pkg_check_modules(AVAHICLIENT REQUIRED avahi-client)
pkg_check_modules(ZMQ REQUIRED libczmq)
pkg_check_modules(UUID REQUIRED uuid)
message("PYTHON DIRS: ${PYTHON_INCLUDE_DIRS}")
find_path(Protobuf_INCLUDE google/protobuf/descriptor.proto PATHS
	/usr/include
	/usr/include/protobuf
	)
list(APPEND PROTOBUF_IMPORT_DIRS ${Protobuf_INCLUDE})


# Local python path and how to run python
set(PYTHONPATH ${MACHINEKIT_SOURCE_DIR}/../lib/python)
set(LOCAL_PYTHON_EXECUTABLE env PYTHONPATH=${PYTHONPATH} ${PYTHON_EXECUTABLE})

# Generate config.h
configure_file(config.h.in config.h)
include_directories("${PROJECT_BINARY_DIR}")
# TODO: Add flavors and _GNU_SOURCE to config.h
# TODO: Do not globally include directories, use sub projects and target_include_directories

# Add global compiler options
add_compile_options(-fPIC)
set_property(GLOBAL PROPERTY C_STANDARD 99)

#  -D_GNU_SOURCE
CHECK_SYMBOL_EXISTS(__GNU_LIBRARY__ "features.h" _GNU_SOURCE)
if (_GNU_SOURCE)
    add_definitions(-D_GNU_SOURCE)
endif()


set(SYSCONFDIR "/etc/machinekit")
set(CMAKE_INSTALL_SYSCONFDIR "${SYSCONFDIR}")

set(RTAPI 1)
set(EMC2_SYSTEM_CONFIG_DIR "${SYSCONFDIR}")
set(PACKAGE_VERSION "${MACHINEKIT_VERSION}")
set(EMC2_DEFAULT_NMLFILE ${CMAKE_INSTALL_FULL_DATADIR}/linuxcnc/linuxcnc.nml)
set(EMC2_HOME ${CMAKE_INSTALL_FULL_PREFIX})
set(EMC2_BIN_DIR ${CMAKE_INSTALL_FULL_BINDIR})
set(EMC2_LIBEXEC_DIR ${CMAKE_INSTALL_FULL_LIBEXECDIR}/linuxcnc)
set(EMC2_LATENCY_SCRIPT ${EMC2_BIN_DIR}/latency-test)
set(EMC2_SCRIPT ${EMC2_BIN_DIR}/emc)
set(EMC2_SUFFIX "")
set(EMC2_ICON machinekiticon)
set(EMC2_TCL_DIR ${CMAKE_INSTALL_FULL_LIBDIR}/tcltk/linuxcnc)
set(EMC2_TCL_LIB_DIR ${CMAKE_INSTALL_FULL_LIBDIR}/tcltk/linuxcnc)
set(EMC2_LANG_DIR ${CMAKE_INSTALL_FULL_DATADIR}/linuxcnc/tcl/msgs)
set(EMC2_PO_DIR ${CMAKE_INSTALL_FULL_LOCALEDIR})
set(EMC2_HELP_DIR ${CMAKE_INSTALL_FULL_DOCDIR}/linuxcnc)
set(EMC2_RTLIB_DIR ${CMAKE_INSTALL_FULL_LIBDIR}/linuxcnc)
set(LINUXCNC_CONFIG_PATH "~/machinekit/configs:${sysconfdir}/linuxcnc/configs:${CMAKE_INSTALL_FULL_DATADIR}/linuxcnc/examples/sample-configs")
set(EMC2_NCFILES_DIR ${CMAKE_INSTALL_FULL_DATADIR}/linuxcnc/ncfiles)
# set(REALTIME ${EMC2_BIN_DIR}/realtime)
set(EMC2_IMAGE_DIR ${CMAKE_INSTALL_FULL_DATADIR}/linuxcnc)



add_definitions(-DRTAPI_FLAVOR_ID=1)
add_definitions(-DRTAPI=${RTAPI})
add_definitions(-DBUILD_SYS_USER_DSO)

add_definitions(-DMACHINEKIT_INI=\"${EMC2_SYSTEM_CONFIG_DIR}/machinekit.ini\")

add_definitions(-DEMC2_SYSTEM_CONFIG_DIR=\"${EMC2_SYSTEM_CONFIG_DIR}\")
add_definitions(-DEMC2_SYSTEM_CONFIG_DIR=\"${EMC2_SYSTEM_CONFIG_DIR}\")
add_definitions(-DEMC2_DEFAULT_NMLFILE=\"${EMC2_DEFAULT_NMLFILE}\")
add_definitions(-DEMC2_HOME=\"${EMC2_HOME}\")
add_definitions(-DEMC2_BIN_DIR=\"${EMC2_BIN_DIR}\")
add_definitions(-DEMC2_LIBEXEC_DIR=\"${EMC2_LIBEXEC_DIR}\")
add_definitions(-DEMC2_LATENCY_SCRIPT=\"${EMC2_LATENCY_SCRIPT}\")
add_definitions(-DEMC2_SCRIPT=\"${EMC2_SCRIPT}\")
add_definitions(-DEMC2_SUFFIX=\"${EMC2_SUFFIX}\")
add_definitions(-DEMC2_ICON=\"${EMC2_ICON}\")
add_definitions(-DEMC2_TCL_DIR=\"${EMC2_TCL_DIR}\")
add_definitions(-DEMC2_TCL_LIB_DIR=\"${EMC2_TCL_LIB_DIR}\")
add_definitions(-DEMC2_LANG_DIR=\"${EMC2_LANG_DIR}\")
add_definitions(-DEMC2_PO_DIR=\"${EMC2_PO_DIR}\")
add_definitions(-DEMC2_HELP_DIR=\"${EMC2_HELP_DIR}\")
add_definitions(-DEMC2_RTLIB_DIR=\"${EMC2_RTLIB_DIR}\")
add_definitions(-DLINUXCNC_CONFIG_PATH=\"${LINUXCNC_CONFIG_PATH}\")
add_definitions(-DEMC2_NCFILES_DIR=\"${EMC2_NCFILES_DIR}\")
# add_definitions(-DREALTIME=\"${REALTIME}\")
add_definitions(-DEMC2_IMAGE_DIR=\"${EMC2_IMAGE_DIR}\")


add_definitions(-DGIT_CONFIG_SHA=\"unknown\")
add_definitions(-DGIT_BUILD_SHA=\"unknown\")

# TESTING:
add_definitions(-DPB_SYSTEM_HEADER=<pb-linuxcnc.h>)

add_subdirectory(inifile)
add_subdirectory(linklist)
add_subdirectory(rs274ngc)
add_subdirectory(libnml)
add_subdirectory(machinetalk)
add_subdirectory(rtapi)
add_subdirectory(rtapi_math)
add_subdirectory(posemath)
add_subdirectory(hal)
add_subdirectory(emc)

install(DIRECTORY ${MACHINEKIT_SOURCE_DIR}/../configs/ DESTINATION ${CMAKE_INSTALL_DATADIR}/linuxcnc/examples/sample-configs)
install(FILES ${MACHINEKIT_SOURCE_DIR}/../configs/common/linuxcnc.nml DESTINATION ${CMAKE_INSTALL_DATADIR}/linuxcnc)