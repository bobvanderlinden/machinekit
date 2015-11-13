
set(KERNEL_DIR "/lib/modules/${CMAKE_SYSTEM_VERSION}/build")
set(MODULE_SOURCE_DIR ${PROJECT_SOURCE_DIR}/src)
set(KBUILD_CMD ${CMAKE_MAKE_PROGRAM}
	-C ${KERNEL_DIR}
	M=${MODULE_SOURCE_DIR}
	modules)
set(kofile ${CMAKE_CURRENT_SOURCE_DIR}/shmdrv.ko)
add_custom_command(OUTPUT ${kofile}
	COMMAND ${kbuild_cmd}
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
	DEPENDS src/shmdrv.c)
add_custom_target (shmdrv ALL DEPENDS ${kofile})
# target_include_directories(shmdrv INTERFACE include)




add_library(linuxcncshm SHARED
	src/shmdrvapi.c)
target_include_directories(linuxcncshm PUBLIC
	include
	$<TARGET_PROPERTY:rtapi,INTERFACE_INCLUDE_DIRECTORIES>
	)
set_target_properties(linuxcncshm PROPERTIES COMPILE_DEFINITIONS "${MACHINEKIT_COMPILE_DEFINITIONS}")

install(
	TARGETS linuxcncshm
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
