add_library(inifile STATIC
  src/inifile.cc)
target_include_directories(inifile PUBLIC include)

# TODO: Only set this for inifile target or in root CMakeLists.txt
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
set(CMAKE_CC_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

install(
  TARGETS inifile
  ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})


add_library(linuxcncini SHARED
	src/inifile.cc
)
target_include_directories(linuxcncini PUBLIC include)

install(
  TARGETS linuxcncini
  LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
)


# TODO: Depend on linuxcncini instead of using inifile.cc
add_executable(inivar
  src/inivar.cc
  src/inifile.cc
  include/inifile.h
  include/inifile.hh
)
target_include_directories(inivar PUBLIC include)
install(
  TARGETS inivar
  RUNTIME DESTINATION ${EMC2_LIBEXEC_DIR}
)
