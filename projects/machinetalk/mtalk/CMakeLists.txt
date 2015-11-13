add_library(mtalk SHARED
	src/pbutil.cc
	src/inihelp.cc
	src/czmq-watch.c
	src/setup_signals.c
	src/syslog_async.c
	src/ll_zeroconf_register.cc
	src/zeroconf_resolve.cc
	src/mk_zeroconf.cc
	src/mk_service.cc
	src/mk_backtrace.c
	src/json2pb.cc
	)

target_include_directories(mtalk
  PUBLIC include
  PRIVATE
  $<TARGET_PROPERTY:mtalk_proto,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:inifile,INTERFACE_INCLUDE_DIRECTORIES>
  ${JANSSON_INCLUDE_DIRS}
  ${AVAHICLIENT_INCLUDE_DIRS}
  ${CZMQ_INCLUDE_DIRS}
  ${UUID_INCLUDE_DIRS}
)
target_link_libraries(mtalk
	PRIVATE  # Using libraries:  don't include the following in linker cmd
	mtalk_proto
	inifile
	${JANSSON_LIBRARIES}
	${AVAHICLIENT_LIBRARIES}
	${CZMQ_LIBRARIES}
	${UUID_LIBRARIES}
	)
set_target_properties(mtalk PROPERTIES
  COMPILE_DEFINITIONS "${machinetalk_DEFINITIONS}"
  SOVERSION "${MACHINEKIT_MAJOR_VERSION}"
  )

install(
	TARGETS mtalk
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
