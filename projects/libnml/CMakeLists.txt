add_library(nml SHARED
	src/rcs/rcs_print.cc
	src/rcs/rcs_exit.cc
	src/os_intf/_sem.c
	src/os_intf/_shm.c
	src/os_intf/_timer.c
	src/os_intf/sem.cc
	src/os_intf/shm.cc
	src/os_intf/timer.cc
	src/buffer/locmem.cc
	src/buffer/memsem.cc
	src/buffer/phantom.cc
	src/buffer/physmem.cc
	src/buffer/recvn.c
	src/buffer/sendn.c
	src/buffer/shmem.cc
	src/buffer/tcpmem.cc
	src/cms/cms.cc
	src/cms/cms_aup.cc
	src/cms/cms_cfg.cc
	src/cms/cms_in.cc
	src/cms/cms_dup.cc
	src/cms/cms_pm.cc
	src/cms/cms_srv.cc
	src/cms/cms_up.cc
	src/cms/cms_xup.cc
	src/cms/cmsdiag.cc
	src/cms/tcp_opts.cc
	src/cms/tcp_srv.cc
	src/nml/cmd_msg.cc
	src/nml/nml_mod.cc
	src/nml/nml_oi.cc
	src/nml/nml_srv.cc
	src/nml/nml.cc
	src/nml/nmldiag.cc
	src/nml/nmlmsg.cc
	src/nml/stat_msg.cc
	)
target_include_directories(nml PUBLIC
	include
	$<TARGET_PROPERTY:linklist,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
	$<TARGET_PROPERTY:posemath,INTERFACE_INCLUDE_DIRECTORIES>
	)
target_link_libraries(nml linklist rtapi_math posemath)


install(
	TARGETS nml
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
