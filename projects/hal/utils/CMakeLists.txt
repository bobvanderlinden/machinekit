# Build hal/utils/comp

# In yapps.py, 'import yapps' tries to import the script itself;
# rename it
add_custom_command(OUTPUT yapps
  COMMAND install -m 755 ${CMAKE_CURRENT_SOURCE_DIR}/yapps.py yapps
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/yapps.py
  DEPENDS ${PYTHONPATH}/yapps/*.py
  COMMENT "Copying yapps python executable"
  )

add_custom_command(OUTPUT comp
  COMMAND ${LOCAL_PYTHON_EXECUTABLE} yapps
  ARGS        ${CMAKE_CURRENT_SOURCE_DIR}/comp.g comp
  COMMAND chmod +x comp
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/comp.g yapps
  COMMENT "Generating comp python executable"
  )

add_custom_target(comp_executable ALL DEPENDS comp)


# TODO: Split files for halcmd from rest of utils.
add_executable(halcmd
  halcmd.c
  halcmd_commands.c
  halcmd_main.c
  halcmd_completion.c
  halcmd_rtapiapp.cc
)
target_include_directories(halcmd PUBLIC
  include
  $<TARGET_PROPERTY:linuxcncini,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:mtalk_proto,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:mtalk,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
  $<TARGET_PROPERTY:rtapi,INTERFACE_INCLUDE_DIRECTORIES>
  ${Readline_INCLUDE_DIR}
)
target_link_libraries(halcmd
  linuxcnc
  linuxcncini
  linuxcnchal
  mtalk_proto
  mtalk
  rtapi_math
  ${Readline_LIBRARY}
)
set_property(TARGET halcmd PROPERTY C_STANDARD 99)

install(
  TARGETS halcmd
  RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})
