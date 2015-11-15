find_file(LSMOD NAMES lsmod)
find_file(PIDOF NAMES pidof)
set(REALTIME ${CMAKE_INSTALL_FULL_BINDIR}/realtime)

configure_file(${MACHINEKIT_SOURCE_DIR}/../scripts/halrun.in halrun @ONLY)
configure_file(${MACHINEKIT_SOURCE_DIR}/../scripts/linuxcnc.in linuxcnc @ONLY)
configure_file(${MACHINEKIT_SOURCE_DIR}/../scripts/machinekit.ini.tmpl.in machinekit.ini @ONLY)
configure_file(${MACHINEKIT_SOURCE_DIR}/../scripts/realtime.in realtime @ONLY)

configure_file(rtapi.ini.in rtapi.ini)

install(PROGRAMS
	${CMAKE_CURRENT_BINARY_DIR}/halrun
	${CMAKE_CURRENT_BINARY_DIR}/linuxcnc
	${CMAKE_CURRENT_BINARY_DIR}/realtime
	DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/machinekit.ini
	${CMAKE_CURRENT_BINARY_DIR}/rtapi.ini
	DESTINATION ${EMC2_SYSTEM_CONFIG_DIR})