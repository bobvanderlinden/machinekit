cmake_minimum_required(VERSION 2.8)
project(rtapi_math)

add_library(rtapi_math SHARED
	src/s_floor.c
	src/e_pow.c
	src/w_pow.c
	src/s_fabs.c
	src/e_sqrt.c
	src/w_sqrt.c
	src/s_ceil.c
	src/e_acos.c
	src/w_acos.c
	src/e_asin.c
	src/w_asin.c
	src/s_tan.c
	src/k_tan.c
	src/s_atan.c
	src/w_atan2.c
	src/e_atan2.c
	src/s_sin.c
	src/k_sin.c
	src/s_cos.c
	src/k_cos.c
	src/e_rem_pio2.c
	src/k_rem_pio2.c
	src/s_scalbn.c
	src/k_standard.c
	src/s_cbrt.c
	src/s_copysign.c
	src/s_finite.c
	src/s_rint.c
	src/powidf.c
	src/e_hypot.c
	src/w_hypot.c
	src/e_fmod.c
	src/w_fmod.c
	src/s_fabs.c
	src/s_rint.c
	src/s_fminmax.c
	src/librtapi_math.c
)

target_include_directories(rtapi_math
  PUBLIC include
  PRIVATE	$<TARGET_PROPERTY:rtapi,INTERFACE_INCLUDE_DIRECTORIES>
  )

target_link_libraries(rtapi_math rtapi)

set_target_properties(rtapi_math PROPERTIES COMPILE_DEFINITIONS
	"_IEEE_LIBM"
	"_ISOC99_SOURCE"
	"_SVID_SOURCE"
)

install(
	TARGETS rtapi_math
	LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
