# Copyright (C) 2006-2018 Istituto Italiano di Tecnologia (IIT)
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

yarp_prepare_plugin(tcpros
                    CATEGORY carrier
                    TYPE yarp::os::TcpRosCarrier
                    INCLUDE TcpRosCarrier.h
                    EXTRA_CONFIG CODE=\(any\)\ \(any\)\ \"\\\\0\\\\0\"\ \(any\)\ \(any\)\ \"\\\\0\\\\0\"
                    DEFAULT ON)

yarp_prepare_plugin(rossrv
                    CATEGORY carrier
                    TYPE yarp::os::RosSrvCarrier
                    INCLUDE TcpRosCarrier.h
                    EXTRA_CONFIG CODE=\(any\)\ \(any\)\ \"\\\\0\\\\0\"\ \(any\)\ \(any\)\ \"\\\\0\\\\0\"
                    DEFAULT ON)

if(NOT SKIP_tcpros OR NOT SKIP_rossrv)
  set(CMAKE_INCLUDE_CURRENT_DIR ON)
  yarp_add_plugin(yarp_tcpros
                  TcpRosCarrier.h
                  TcpRosCarrier.cpp
                  TcpRosStream.h
                  TcpRosStream.cpp
                  RosHeader.h
                  RosHeader.cpp
                  RosSlave.h
                  RosLookup.h
                  RosLookup.cpp)
  target_link_libraries(yarp_tcpros PRIVATE YARP::YARP_OS
                                            YARP::YARP_sig
                                            YARP::YARP_wire_rep_utils)
  list(APPEND YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS YARP_OS
                                                      YARP_sig
                                                      YARP_wire_rep_utils)

  yarp_install(TARGETS yarp_tcpros
               EXPORT YARP_${YARP_PLUGIN_MASTER}
               COMPONENT ${YARP_PLUGIN_MASTER}
               LIBRARY DESTINATION ${YARP_DYNAMIC_PLUGINS_INSTALL_DIR}
               ARCHIVE DESTINATION ${YARP_STATIC_PLUGINS_INSTALL_DIR})
  yarp_install(FILES ros.ini
               COMPONENT ${YARP_PLUGIN_MASTER}
               DESTINATION ${YARP_PLUGIN_MANIFESTS_INSTALL_DIR})

  set(YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS ${YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS} PARENT_SCOPE)

  set_property(TARGET yarp_tcpros PROPERTY FOLDER "Plugins/Carrier")


  # yarpros executable
  add_executable(yarpros yarpros.cpp
                         TcpRosStream.cpp
                         RosLookup.cpp)
  target_link_libraries(yarpros PRIVATE YARP::YARP_OS
                                        YARP::YARP_init
                                        YARP::YARP_wire_rep_utils)
  install(TARGETS yarpros
          EXPORT YARP_${YARP_PLUGIN_MASTER}
          COMPONENT utilities
          DESTINATION ${CMAKE_INSTALL_BINDIR})

  set_property(TARGET yarpros PROPERTY FOLDER "Command Line Tools")
endif()
