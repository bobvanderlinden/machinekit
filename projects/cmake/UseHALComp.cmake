# Define a function to create HAL comps.
#
# This file defines a CMake function to build a HAL component.
# To use it, first include this file.
#
#   include( UseHALComp )
#
# Then call hal_add_comp to create a component.
#
#   hal_comp_add_module( <comp_name> )
#

#=============================================================================
# Copyright 2015 John Morris <john@zultron.com>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# =============================================================================

# TODO:
#
# If this could be packaged as an out-of-tree comp CMake helper, it
# needs to be generalized, esp. ${MACHINEKIT_SOURCE_DIR}

# hal_comp_add_module _name [ dependency ... ]
function(hal_comp_add_module _name)
  set(comp_source "${_name}.comp")
  set(comp_c "${_name}.c")
  add_custom_command(OUTPUT ${comp_c}
    COMMAND ${COMP_EXECUTABLE}
    ARGS --require-license -o ${comp_c} ${comp_source} ${ARGN}
    DEPENDS ${comp_source} ${ARGN}
    DEPENDS ${COMP_DEPEND}
    COMMENT "Preprocessing comp ${_name}"
    )
  add_library(${_name} MODULE
    ${comp_c} ${ARGN}
    )
  set_target_properties(${_name} PROPERTIES PREFIX "") # Don't prepend 'lib'
  target_include_directories(${_name} PRIVATE
    $<TARGET_PROPERTY:rtapi,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:rtapi_math,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:linuxcnchal,INTERFACE_INCLUDE_DIRECTORIES>
    )
endfunction()

function(hal_conv_comp_add_module _name in_type out_type)
  if(ARGN)
    set(min ${ARGV3})
    set(max ${ARGV4})
  else()
    set(comment "//")
    set(min 0)
    set(max 0)
  endif()
  if(NOT ${in_type} STREQUAL "float" AND NOT ${out_type} STREQUAL "float")
    set(F "nofp")
  endif()
  add_custom_command(OUTPUT "${_name}.comp"
    COMMAND sed < conv.comp.in > "${_name}.comp"
    -e "s,@IN@,${in_type},g"
    -e "s,@OUT@,${out_type},g"
    -e "s,@CC@,${comment},g"
    -e "s,@MIN@,${min},g"
    -e "s,@MAX@,${max},g"
    -e "s,@FP@,${F},g"
    DEPENDS conv.comp.in
    COMMENT "Converting conf for and preprocessing ${_name}"
    )    
  hal_comp_add_module(${_name})
endfunction()

function(hal_driver_comp_add_module _name)
  hal_comp_add_module(${_name})
  # Add userpci header directory
  target_include_directories(${_name} PRIVATE
    ${MACHINEKIT_SOURCE_DIR}/rtapi/userpci/include)
endfunction()

# Build hal/utils/comp.py
#
# Put this ugliness, only needed for in-tree build, at the bottom
function(build_in_tree_comp)
  set(python_path ${MACHINEKIT_SOURCE_DIR}/../lib/python)
  set(yapps_lib "${python_path}/yapps")
  set(python env PYTHONPATH=${python_path} ${PYTHON_EXECUTABLE})
  set(hal_utils_dir ${MACHINEKIT_SOURCE_DIR}/hal/utils)

  add_custom_command(OUTPUT ${hal_utils_dir}/comp.py
    COMMAND ${python} ${hal_utils_dir}/yapps ${hal_utils_dir}/comp.g
    DEPENDS ${hal_utils_dir}/comp.g ${hal_utils_dir}/yapps
    DEPENDS ${yapps_lib}/__init__.py ${yapps_lib}/grammar.py
    DEPENDS ${yapps_lib}/parsetree.py ${yapps_lib}/runtime.py
    COMMENT "Generating comp.py"
    )

  # Tell the hal_comp_add_module() function the wacky python command
  # line and the comp.py dep location
  set(COMP_EXECUTABLE env PYTHONPATH=${python_path}
    ${PYTHON_EXECUTABLE} ${hal_utils_dir}/comp.py
    PARENT_SCOPE)
  set(COMP_DEPEND ${hal_utils_dir}/comp.py PARENT_SCOPE)
endfunction()
