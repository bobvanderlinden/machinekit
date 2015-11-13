add_library(rs274ngc SHARED
	src/interp_arc.cc
	src/interp_array.cc
	src/interp_base.cc
	src/interp_check.cc
	src/interp_convert.cc
	src/interp_queue.cc
	src/interp_cycles.cc
	src/interp_execute.cc
	src/interp_find.cc
	src/interp_internal.cc
	src/interp_inverse.cc
	src/interp_read.cc
	src/interp_write.cc
	src/interp_o_word.cc
	src/modal_state.cc
	src/nurbs_additional_functions.cc
	src/interp_namedparams.cc
	src/interp_python.cc
	src/interp_remap.cc
	src/interp_setup.cc
	src/canonmodule.cc
	src/pyparamclass.cc
	src/pyemctypes.cc
	src/pyinterp1.cc
	src/pyblock.cc
	src/pyarrays.cc
	src/interpmodule.cc
	src/rs274ngc_pre.cc
	)
set_target_properties(rs274ngc PROPERTIES COMPILE_DEFINITIONS "${MACHINEKIT_COMPILE_DEFINITIONS};PACKAGE_VERSION=\"${PACKAGE_VERSION}\"")
target_include_directories(rs274ngc PUBLIC
	include
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:linuxcnc,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:motmod,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:pyplugin,INTERFACE_INCLUDE_DIRECTORIES>
	${PYTHON_INCLUDE_DIRS}
	${Boost_INCLUDE_DIRS}
	)
target_link_libraries(rs274ngc rtapi_math linuxcnc pyplugin ${PYTHON_LIBRARIES} ${Boost_LIBRARIES})

install(
	TARGETS rs274ngc
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
