add_library(inifile STATIC
  src/inifile.cc)
target_include_directories(inifile PUBLIC include)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
set(CMAKE_CC_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

add_library(linuxcncini
	src/inifile.cc
)
target_include_directories(linuxcncini PUBLIC include)

# TODO: Depend on linuxcncini instead of using inifile.cc
add_executable(inivar
  src/inivar.cc
  src/inifile.cc
  include/inifile.h
  include/inifile.hh)
target_include_directories(inivar PUBLIC include)