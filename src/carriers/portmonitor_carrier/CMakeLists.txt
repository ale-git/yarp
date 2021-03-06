# Copyright (C) 2006-2018 Istituto Italiano di Tecnologia (IIT)
# All rights reserved.
#
# This software may be modified and distributed under the terms of the
# BSD-3-Clause license. See the accompanying LICENSE file for details.

yarp_prepare_plugin(portmonitor
                    TYPE yarp::os::PortMonitor
                    INCLUDE PortMonitor.h
                    CATEGORY carrier
                    EXTRA_CONFIG SUBTYPE=recv
                                 CODE="not applicable"
                    DEFAULT ON)

if (NOT SKIP_portmonitor)
  set(CMAKE_INCLUDE_CURRENT_DIR ON)

  if(LUA_FOUND)
    set(portmonitor_LUA_SRCS lua/MonitorLua.cpp lua/MonitorLua.h)
  endif()

  yarp_add_plugin(yarp_portmonitor
                  PortMonitor.h
                  MonitorBinding.h
                  MonitorEvent.h
                  PortMonitor.cpp
                  MonitorBinding.cpp
                  dll/MonitorSharedLib.h
                  dll/MonitorSharedLib.cpp
                  ${portmonitor_LUA_SRCS})

  target_include_directories(yarp_portmonitor PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/dll)
  target_link_libraries(yarp_portmonitor PRIVATE YARP::YARP_OS)
  list(APPEND YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS YARP_OS)

  if(LUA_FOUND)
    target_include_directories(yarp_portmonitor PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/lua)
    target_include_directories(yarp_portmonitor SYSTEM PRIVATE ${LUA_INCLUDE_DIR})
    target_compile_definitions(yarp_portmonitor PRIVATE ENABLED_PORTMONITOR_LUA)
    target_link_libraries(yarp_portmonitor PRIVATE ${LUA_LIBRARY})
#     list(APPEND YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS Lua) (not using targets)
  endif()

  yarp_install(TARGETS yarp_portmonitor
               EXPORT YARP_${YARP_PLUGIN_MASTER}
               COMPONENT ${YARP_PLUGIN_MASTER}
               LIBRARY DESTINATION ${YARP_DYNAMIC_PLUGINS_INSTALL_DIR}
               ARCHIVE DESTINATION ${YARP_STATIC_PLUGINS_INSTALL_DIR})
  yarp_install(FILES portmonitor.ini
               COMPONENT ${YARP_PLUGIN_MASTER}
               DESTINATION ${YARP_PLUGIN_MANIFESTS_INSTALL_DIR})

  set(YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS ${YARP_${YARP_PLUGIN_MASTER}_PRIVATE_DEPS} PARENT_SCOPE)

  set_property(TARGET yarp_portmonitor PROPERTY FOLDER "Plugins/Carrier")
endif()
