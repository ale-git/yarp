# Copyright (C) 2006-2018 Istituto Italiano di Tecnologia (IIT)
# Copyright (C) 2006-2010 RobotCub Consortium
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

add_library(YARP_wire_rep_utils STATIC WireImage.cpp
                                       WireImage.h
                                       WireBottle.cpp
                                       WireBottle.h
                                       WireTwiddler.cpp
                                       WireTwiddler.h)
add_library(YARP::YARP_wire_rep_utils ALIAS YARP_wire_rep_utils)

target_include_directories(YARP_wire_rep_utils PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                                                      $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_link_libraries(YARP_wire_rep_utils PUBLIC YARP::YARP_conf
                                                 YARP::YARP_OS
                                                 YARP::YARP_sig)
list(APPEND YARP_wire_rep_utils_PUBLIC_DEPS YARP_conf
                                            YARP_OS
                                            YARP_sig)

if(YARP_HAS_ACE)
  target_include_directories(YARP_wire_rep_utils SYSTEM PRIVATE ${ACE_INCLUDE_DIRS})
  target_link_libraries(YARP_wire_rep_utils PRIVATE ${ACE_LIBRARIES})
  list(APPEND YARP_wire_rep_utils_PRIVATE_DEPS ACE)
endif()

target_compile_features(YARP_wire_rep_utils PUBLIC cxx_nullptr
                                                   cxx_override)

set_property(TARGET YARP_serversql PROPERTY VERSION ${YARP_VERSION_SHORT})
set_property(TARGET YARP_serversql PROPERTY SOVERSION ${YARP_SOVERSION})

install(TARGETS YARP_wire_rep_utils
        EXPORT YARP_wire_rep_utils
        COMPONENT YARP_wire_rep_utils
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}")

include(YarpInstallBasicPackageFiles)
yarp_install_basic_package_files(YARP_wire_rep_utils
                                 DEPENDENCIES ${YARP_wire_rep_utils_PUBLIC_DEPS}
                                 PRIVATE_DEPENDENCIES ${YARP_wire_rep_utils_PRIVATE_DEPS})

set_property(TARGET YARP_wire_rep_utils PROPERTY FOLDER "Libraries/Private")
