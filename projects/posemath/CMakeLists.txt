add_library(posemath SHARED
	src/_posemath.c
	src/posemath.cc
	src/gomath.c
	src/sincos.c)
target_include_directories(posemath PUBLIC
	include
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>)

install(
	TARGETS posemath
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
