#
# hal.so cython module
#
cython_add_module(hal
  hal.pyx
  ${MACHINEKIT_SOURCE_DIR}/hal/utils/halcmd_rtapiapp.cc
  # cimports
  hal.pxd
  hal_const.pxd
  hal_iter.pxd
  hal_priv.pxd
  hal_rcomp.pxd
  hal_ring.pxd
  ring_const.pxd
  rtapi.pxd
  )
target_link_libraries(hal
  linuxcnchal
  mtalk
  )

#
# rtapi.so cython module
#
# Logical target "rtapi" exists, so call this "rtapi_cython"
cython_add_module(rtapi_cython
  rtapi.pyx
  ${MACHINEKIT_SOURCE_DIR}/hal/utils/halcmd_rtapiapp.cc
  # cimports
  rtapi.pxd
  global_data.pxd
  rtapi_app.pxd
  buffer.pxd
  # headers from machinetalk/mtalk_proto
  ${ProtoHeaders}
  )
target_link_libraries(rtapi_cython
  linuxcnchal
  mtalk
  )
set_target_properties(rtapi_cython PROPERTIES
  OUTPUT_NAME "rtapi"
  )
target_include_directories(rtapi_cython PRIVATE
  "${MACHINEKIT_SOURCE_DIR}/hal/utils"
  )

#
# compat.so cython module
#
cython_add_module(compat
  compat.pyx
  # cimports
  compat.pxd
  )
target_link_libraries(compat
  linuxcnchal
  )

#
# shmcommon.so cython module
#
cython_add_module(shmcommon
  shmcommon.pyx
  # cimports
  shmcommon.pxd
  global_data.pxd
  )
target_include_directories(shmcommon PUBLIC
  $<TARGET_PROPERTY:linuxcncshm,INTERFACE_INCLUDE_DIRECTORIES>
  )
