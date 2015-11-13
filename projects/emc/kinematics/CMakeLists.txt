add_library(lineardeltakins SHARED
	src/lineardeltakins.cc
)
target_include_directories(lineardeltakins PUBLIC
	include
	$<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:posemath,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	${Boost_INCLUDE_DIR}
	)
target_link_libraries(lineardeltakins linuxcnchal posemath rtapi_math ${Boost_LIBRARIES})

install(
	TARGETS lineardeltakins
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})


add_library(cubic STATIC
	src/cubic.c
)
target_include_directories(cubic PUBLIC
	include
	$<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:posemath,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
	${Boost_INCLUDE_DIR}
	)

install(
	TARGETS cubic
	ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})

# add_executable(genserkins
# 	src/genserkins.c
# 	)
# target_include_directories(genserkins PUBLIC
# 	include
# 	$<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
# 	$<TARGET_PROPERTY:posemath,INTERFACE_INCLUDE_DIRECTORIES>
# 	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
# 	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
# 	${Boost_INCLUDE_DIR}
# 	)
# target_link_libraries(genserkins linuxcnchal posemath rtapi_math linuxcnc)