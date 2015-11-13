add_library(motmod SHARED
	src/motion.c
	src/command.c
	src/control.c
	src/homing.c
	src/emcmotglb.c
	src/emcmotutil.c
	src/stashf.c
	src/dbuf.c
	)
target_include_directories(motmod PUBLIC
	include
	$<TARGET_PROPERTY:posemath,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:cubic,INTERFACE_INCLUDE_DIRECTORIES>
	)
target_link_libraries(motmod posemath linuxcnc cubic)

install(
	TARGETS motmod
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
