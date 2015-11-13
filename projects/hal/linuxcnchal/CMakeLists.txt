add_library(linuxcnchal SHARED
	src/hal_lib.c
	src/hal_group.c
	src/hal_ring.c
	src/hal_iter.c
	src/hal_rcomp.c
	src/hal_vtable.c
	src/hal_funct.c
	src/hal_procfs.c
	src/hal_thread.c
	src/hal_param.c
	src/hal_alias.c
	src/hal_signal.c
	src/hal_pin.c
	src/hal_comp.c
	src/hal_memory.c
	src/hal_misc.c
	src/hal_instance.c)

target_include_directories(linuxcnchal
  PUBLIC include
  PRIVATE
  $<TARGET_PROPERTY:rtapi,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:shmdrv,INTERFACE_INCLUDE_DIRECTORIES>
  )
set_target_properties(linuxcnchal PROPERTIES
  COMPILE_DEFINITIONS "${MACHINEKIT_COMPILE_DEFINITIONS}"
  SOVERSION "${MACHINEKIT_MAJOR_VERSION}"
  )

install(
	TARGETS linuxcnchal
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
