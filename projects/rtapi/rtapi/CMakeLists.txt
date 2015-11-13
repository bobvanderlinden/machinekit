add_library(rtapi SHARED
	# TODO: Figure out how to build all flavors and rest of these files.
	# src/rtapi_kdetect.c
	src/rt-preempt.c
	# src/flavor.c
	src/rtapi_main.c
	src/rtapi_time.c
	# src/ulapi_main.c
	# src/rtapi_msgd.cc
	src/rtapi_hexdump.c
	src/rtapi_exception.c
	# src/ulapi_autoload.c
	# src/test_rtapi_vsnprintf.c
	# src/rtapi_pci.c
	# src/rtai-kernel.c
	# src/xenomai.c
	src/rtapi_support.c
	# src/userpci/firmware.c
	# src/userpci/device.c
	# src/userpci/string.c
	src/rtapi_shmem.c
	# src/xenomai-kernel.c
	src/rtapi_task.c
	src/rtapi_heap.c
	# src/shmdrv/shmdrv.c
	# src/shmdrv/shmdrvapi.c
	# src/shmdrv/mutexwatch.c
	# src/rtapi_module.c
	src/rtapi_common.c
	# src/rtapi_app.cc
	src/rtapi_compat.c
	# src/rtapi_hexdump.c
)

# TODO: Build kernel module.
set(KERNEL_DIR "/lib/modules/${CMAKE_SYSTEM_VERSION}/build")
find_path(KERNEL_INCLUDE_DIR linux/module.h PATHS "${KERNEL_DIR}/include")
find_path(KERNEL_ARCH_INCLUDE_DIR asm/linkage.h PATHS
	"${KERNEL_DIR}/arch/x86/include"
	"${KERNEL_DIR}/arch/arm/include"
	)
set(KERNEL_INCLUDE_DIRS "${KERNEL_INCLUDE_DIR}" "${KERNEL_ARCH_INCLUDE_DIR}")



target_include_directories(rtapi
  PUBLIC
	include
  PRIVATE
	$<TARGET_PROPERTY:inifile,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:mtalk,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:mtalk_proto,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcncshm,INTERFACE_INCLUDE_DIRECTORIES>
	# ${KERNEL_INCLUDE_DIRS}
	)

set(rtapi_definitions
	THREAD_FLAVOR_ID=RTAPI_POSIX_ID
	THREAD_FLAVOR_NAME=RTAPI_POSIX_NAME
	)

set_target_properties(rtapi PROPERTIES COMPILE_DEFINITIONS "${rtapi_definitions}")
target_link_libraries(rtapi inifile mtalk mtalk_proto linuxcnchal linuxcncshm)

install(
	TARGETS rtapi
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})



add_executable(rtapi_app_posix
	src/rtapi_app.cc
	src/rtapi_compat.c
	src/rtapi_hexdump.c
	src/rtapi_support.c
	)
target_include_directories(rtapi_app_posix
  PUBLIC
	include
  PRIVATE
	$<TARGET_PROPERTY:linuxcncini,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcncshm,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:mtalk,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:mtalk_proto,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
	)
target_link_libraries(rtapi_app_posix
	linuxcncini
	linuxcncshm
	mtalk
	mtalk_proto
	rtapi_math
	)
install(
	TARGETS rtapi_app_posix
	RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})

add_executable(rtapi_msgd
	src/rtapi_msgd.cc
	src/rtapi_heap.c
	src/rtapi_compat.c
	)
target_include_directories(rtapi_msgd
  PUBLIC
	include
  PRIVATE
	$<TARGET_PROPERTY:linuxcncshm,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcncini,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:mtalk,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:mtalk_proto,INTERFACE_INCLUDE_DIRECTORIES>
	${CZMQ_INCLUDE_DIRS}
	${UUID_INCLUDE_DIRS}
	)
target_link_libraries(rtapi_msgd
	linuxcncshm
	linuxcncini
	mtalk
	mtalk_proto
	${CZMQ_LIBRARY}
	${UUID_LIBRARY}
	)
install(
	TARGETS rtapi_msgd
	RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})


add_executable(flavor
	src/flavor.c
	src/rtapi_compat.c)
target_include_directories(flavor PRIVATE
	include
	$<TARGET_PROPERTY:inifile,INTERFACE_INCLUDE_DIRECTORIES>)
target_link_libraries(flavor inifile)

install(
	TARGETS flavor
	RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})
