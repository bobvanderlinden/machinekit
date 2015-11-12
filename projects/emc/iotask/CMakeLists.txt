add_executable(io
	ioControl.cc
	${MACHINEKIT_SOURCE_DIR}/rs274ngc/src/tool_parse.cc
)
target_include_directories(io PUBLIC
	include
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:nml,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcncini,INTERFACE_INCLUDE_DIRECTORIES>
)
target_link_libraries(io
	linuxcnc
	nml
	linuxcnchal
	linuxcncini
)


add_executable(iov2
	ioControl_v2.cc
	${MACHINEKIT_SOURCE_DIR}/rs274ngc/src/tool_parse.cc
)
target_include_directories(iov2 PUBLIC
	include
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:nml,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcncini,INTERFACE_INCLUDE_DIRECTORIES>
)
target_link_libraries(iov2
	nml
	rtapi_math
	linuxcnc
	motmod
	linuxcnchal
	nml
	linuxcncini
)
