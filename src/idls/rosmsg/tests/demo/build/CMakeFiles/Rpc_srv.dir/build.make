# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /opt/iit/src/yarp/src/idls/rosmsg/tests/demo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build

# Utility rule file for Rpc_srv.

# Include the progress variables for this target.
include CMakeFiles/Rpc_srv.dir/progress.make

CMakeFiles/Rpc_srv: bits/Rpc_srv.cmake

bits/Rpc_srv.cmake: ../Rpc.srv
	$(CMAKE_COMMAND) -E cmake_progress_report /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating bits/Rpc_srv.cmake, bits/include/Rpc.h, bits/include/RpcReply.h, bits/include/RpcReply.h"
	cd /opt/iit/src/yarp/src/idls/rosmsg/tests/demo && /opt/iit/build/yarp/bin/yarpidl_rosmsg --out /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/_yarp_idl_ --gen yarp:include_prefix --I /opt/iit/src/yarp/src/idls/rosmsg/tests/demo Rpc.srv
	cd /opt/iit/src/yarp/src/idls/rosmsg/tests/demo && /usr/bin/cmake -P /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/_yarp_idl_/placeRpc.cmake

bits/include/Rpc.h: bits/Rpc_srv.cmake

bits/include/RpcReply.h: bits/Rpc_srv.cmake

bits/include/RpcReply.h: bits/Rpc_srv.cmake

Rpc_srv: CMakeFiles/Rpc_srv
Rpc_srv: bits/Rpc_srv.cmake
Rpc_srv: bits/include/Rpc.h
Rpc_srv: bits/include/RpcReply.h
Rpc_srv: bits/include/RpcReply.h
Rpc_srv: CMakeFiles/Rpc_srv.dir/build.make
.PHONY : Rpc_srv

# Rule to build all files generated by this target.
CMakeFiles/Rpc_srv.dir/build: Rpc_srv
.PHONY : CMakeFiles/Rpc_srv.dir/build

CMakeFiles/Rpc_srv.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Rpc_srv.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Rpc_srv.dir/clean

CMakeFiles/Rpc_srv.dir/depend:
	cd /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/iit/src/yarp/src/idls/rosmsg/tests/demo /opt/iit/src/yarp/src/idls/rosmsg/tests/demo /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/CMakeFiles/Rpc_srv.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Rpc_srv.dir/depend

