# Copyright (C) 2006-2018 Istituto Italiano di Tecnologia (IIT)
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

project(YARP_rosmsg)

include(YarpIDL)

# * yarpidl_rosmsg depends on YARP_init. This means that on static builds the
#   tool for re-generating the files depends on the generated files (yes, this
#   is madness). For now the only way to fix this is to use pre-generated files.
# * For cross-compiling, generating the files at build time could be an issue,
#   hence use pre-generated files.
# * Finally if ALLOW_IDL_GENERATION is enabled, we want to re-generate the
#   pre-generated files.
macro(_yarp_choose_idl _prefix)
  unset(${_prefix}_GEN_FILES)
  if(NOT "${ARGN}" STREQUAL "")
    if(BUILD_SHARED_LIBS AND
       NOT CMAKE_CROSSCOMPILING AND
       NOT ALLOW_IDL_GENERATION AND
       YARP_COMPILE_EXECUTABLES)
      yarp_add_idl(${_prefix}_GEN_FILES
                   ${ARGN})
      set(${_prefix}_BUILD_INTERFACE_INCLUDE_DIRS "${CMAKE_CURRENT_BINARY_DIR}/include")
    else()
      foreach(_msg ${ARGN})
        yarp_idl_to_dir(${_msg}
                        "${CMAKE_CURRENT_SOURCE_DIR}/idl_generated_code"
                        ${_prefix}_GEN_SRCS
                        ${_prefix}_GEN_HDRS
                        ${_prefix}_BUILD_INTERFACE_INCLUDE_DIRS)
        set(${_prefix}_GEN_FILES ${${_prefix}_GEN_SRCS} ${${_prefix}_GEN_HDRS})
      endforeach()
    endif()
  endif()
endmacro()

# yarpRosHelper.h is used by several devices
# For now in impl since it might be removed in the future
set(YARP_rosmsgs_IMPL_HDRS include/yarp/rosmsg/impl/yarpRosHelper.h)
source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}"
             PREFIX "Header Files"
             FILES ${YARP_rosmsgs_IMPL_HDRS})


# Add main target
add_custom_target(YARP_rosmsg_gen_all ALL)
set_property(TARGET YARP_rosmsg_gen_all PROPERTY FOLDER "Libraries/YARP_rosmsg")

# Add main library
add_library(YARP_rosmsg INTERFACE)
add_library(YARP::YARP_rosmsg ALIAS YARP_rosmsg)
target_include_directories(YARP_rosmsg INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                                                 $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
target_link_libraries(YARP_rosmsg INTERFACE YARP::YARP_OS)
list(APPEND YARP_rosmsg_PUBLIC_DEPS YARP_OS)

add_dependencies(YARP_rosmsg YARP_rosmsg_gen_all)


# ROS native types
_yarp_choose_idl(native_MSG
                 time
                 duration)

add_custom_target(YARP_rosmsg_gen_native DEPENDS ${native_MSG_GEN_FILES})
set_property(TARGET YARP_rosmsg_gen_native PROPERTY FOLDER "Libraries/YARP_rosmsg")

add_library(YARP_rosmsg_native INTERFACE)
add_library(YARP::YARP_rosmsg_native ALIAS YARP_rosmsg_native)
target_include_directories(YARP_rosmsg_native INTERFACE $<BUILD_INTERFACE:${native_MSG_BUILD_INTERFACE_INCLUDE_DIRS}>
                                                        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
target_link_libraries(YARP_rosmsg_native INTERFACE YARP::YARP_OS)
list(APPEND YARP_rosmsg_native_PUBLIC_DEPS YARP_OS)

add_dependencies(YARP_rosmsg_gen_all YARP_rosmsg_gen_native)
target_link_libraries(YARP_rosmsg INTERFACE YARP::YARP_rosmsg_native)
list(APPEND YARP_rosmsg_PUBLIC_DEPS YARP_rosmsg_native)

# Deprecated files are not installed since they were never installed
# YARP_NO_DEPRECATED since YARP v3.0.0
unset(native_INSTALL_FILES)
foreach(_file ${native_MSG_GEN_FILES})
  if("${_file}" MATCHES "yarp/rosmsg/")
    list(APPEND native_INSTALL_FILES "${_file}")
  endif()
endforeach()



# Other ROS packages
foreach(_pkg ${ROS_MSG_PACKAGES})
  # Force CMake to run again if package.xml is updated, i.e. we included a new
  # version of the package.
  # This makes it safe to use file(GLOB)
  set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${ROS_${_pkg}_ROOT}/package.xml")

  # Generate list of .msg and .srv files
  file(GLOB ${_pkg}_MSG_FILES "${ROS_${_pkg}_ROOT}/msg/*.msg")
  file(GLOB ${_pkg}_SRV_FILES "${ROS_${_pkg}_ROOT}/srv/*.srv")

  source_group(TREE "${ROS_${_pkg}_ROOT}"
               PREFIX "${_pkg} .msg Files"
               FILES ${${_pkg}_MSG_FILES})
  source_group (TREE "${ROS_${_pkg}_ROOT}"
                PREFIX "${_pkg} .srv Files"
                FILES ${${_pkg}_SRV_FILES})

  # Call yarp_add_idl or yarp_idl_to_dir
  _yarp_choose_idl(${_pkg}_MSG ${${_pkg}_MSG_FILES})
  _yarp_choose_idl(${_pkg}_SRV ${${_pkg}_SRV_FILES})

  # Add custom target and set it as YARP_rosmsg_gen_all dependency
  add_custom_target(YARP_rosmsg_gen_${_pkg} DEPENDS ${${_pkg}_MSG_GEN_FILES}
                                                    ${${_pkg}_SRV_GEN_FILES})
  set_property(TARGET YARP_rosmsg_gen_${_pkg} PROPERTY FOLDER "Libraries/YARP_rosmsg")
  add_dependencies(YARP_rosmsg_gen_all YARP_rosmsg_gen_${_pkg})

  # Add library
  add_library(YARP_rosmsg_${_pkg} INTERFACE)
  add_library(YARP::YARP_rosmsg_${_pkg} ALIAS YARP_rosmsg_${_pkg})
  target_include_directories(YARP_rosmsg_${_pkg} INTERFACE $<BUILD_INTERFACE:${${_pkg}_MSG_BUILD_INTERFACE_INCLUDE_DIRS}>
                                                           $<BUILD_INTERFACE:${${_pkg}_SRV_BUILD_INTERFACE_INCLUDE_DIRS}>
                                                           $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
  target_link_libraries(YARP_rosmsg_${_pkg} INTERFACE YARP::YARP_OS
                                                      YARP::YARP_rosmsg_native)
  list(APPEND YARP_rosmsg_${_pkg}_PUBLIC_DEPS YARP_OS
                                              YARP_rosmsg_native)

  # YARP_rosmsg depends on all the packages
  add_dependencies(YARP_rosmsg YARP_rosmsg_gen_${_pkg})
  target_link_libraries(YARP_rosmsg INTERFACE YARP::YARP_rosmsg_${_pkg})
  list(APPEND YARP_rosmsg_PUBLIC_DEPS YARP_rosmsg_${_pkg})

  # Install files and exports
  # Deprecated files are not installed since they were never installed
  # YARP_NO_DEPRECATED since YARP v3.0.0
  unset(${_pkg}_INSTALL_FILES)
  foreach(_file ${${_pkg}_MSG_GEN_FILES}
                ${${_pkg}_SRV_GEN_FILES})
    if("${_file}" MATCHES "yarp/rosmsg/${_pkg}/")
      list(APPEND ${_pkg}_INSTALL_FILES "${_file}")
    endif()
  endforeach()
endforeach()

# Handle dependencies after adding all packages so that we can ignore the
# actual order when adding the libraries
foreach(_pkg ${ROS_MSG_PACKAGES})
  file(STRINGS "${ROS_${_pkg}_ROOT}/package.xml" _content REGEX "build_depend")
  if(_content)
    foreach(_line ${_content})
      string(REGEX REPLACE "^.*<build_depend.*>(.+)</build_depend>.*" "\\1" _dep "${_line}")
      if(TARGET YARP::YARP_rosmsg_${_dep})
        target_link_libraries(YARP_rosmsg_${_pkg} INTERFACE YARP::YARP_rosmsg_${_dep})
        list(APPEND YARP_rosmsg_${_pkg}_PUBLIC_DEPS YARP_rosmsg_${_dep})
      endif()
    endforeach()
  endif()
endforeach()


# Install all libraries and all files

include(YarpInstallBasicPackageFiles)

install(TARGETS YARP_rosmsg_native
        EXPORT YARP_rosmsg_native
        COMPONENT YARP_rosmsg_native)
install(FILES ${native_INSTALL_FILES}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/yarp/rosmsg)
yarp_install_basic_package_files(YARP_rosmsg_native
                                 DEPENDENCIES ${YARP_rosmsg_native_PUBLIC_DEPS}
                                 PRIVATE_DEPENDENCIES ${YARP_rosmsg_native_PRIVATE_DEPS})

foreach(_pkg ${ROS_MSG_PACKAGES})
  install(TARGETS YARP_rosmsg_${_pkg}
          EXPORT YARP_rosmsg_${_pkg}
          COMPONENT YARP_rosmsg_${_pkg})
  install(FILES ${${_pkg}_INSTALL_FILES}
          DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/yarp/rosmsg/${_pkg}
          COMPONENT development)
  yarp_install_basic_package_files(YARP_rosmsg_${_pkg}
                                   DEPENDENCIES ${YARP_rosmsg_${_pkg}_PUBLIC_DEPS}
                                   PRIVATE_DEPENDENCIES ${YARP_rosmsg_${_pkg}_PRIVATE_DEPS})
endforeach()

install(TARGETS YARP_rosmsg
        EXPORT YARP_rosmsg
        COMPONENT YARP_rosmsg)
install(FILES ${YARP_rosmsgs_IMPL_HDRS}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/yarp/rosmsg/impl)
yarp_install_basic_package_files(YARP_rosmsg
                                 DEPENDENCIES ${YARP_rosmsg_PUBLIC_DEPS}
                                 PRIVATE_DEPENDENCIES ${YARP_rosmsg_PRIVATE_DEPS})
