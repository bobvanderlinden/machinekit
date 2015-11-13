add_executable(milltask
	src/emctaskmain.cc
	src/emctask.cc
	src/emccanon.cc
	src/taskmodule.cc
	src/taskclass.cc
	src/backtrace.cc
	src/taskintf.cc
	src/usrmotintf.cc
)
target_include_directories(milltask PUBLIC
	include
	$<TARGET_PROPERTY:nml,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	)
target_link_libraries(milltask nml rs274ngc linuxcnc motmod pyplugin)

install(
	TARGETS milltask
	RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})


add_executable(linuxcncsvr
	src/emcsvr.cc
)
target_include_directories(linuxcncsvr PUBLIC
	include
	$<TARGET_PROPERTY:nml,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
	)
target_link_libraries(linuxcncsvr nml rtapi_math linuxcnc motmod linuxcnchal)

install(
	TARGETS linuxcncsvr
	RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})
