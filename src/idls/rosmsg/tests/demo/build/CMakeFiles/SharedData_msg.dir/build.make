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

# Utility rule file for SharedData_msg.

# Include the progress variables for this target.
include CMakeFiles/SharedData_msg.dir/progress.make

CMakeFiles/SharedData_msg: bits/SharedData_msg.cmake

bits/SharedData_msg.cmake: ../SharedData.msg
	$(CMAKE_COMMAND) -E cmake_progress_report /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating bits/SharedData_msg.cmake, bits/include/SharedData.h"
	cd /opt/iit/src/yarp/src/idls/rosmsg/tests/demo && /opt/iit/build/yarp/bin/yarpidl_rosmsg --out /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/_yarp_idl_ --gen yarp:include_prefix --I /opt/iit/src/yarp/src/idls/rosmsg/tests/demo SharedData.msg
	cd /opt/iit/src/yarp/src/idls/rosmsg/tests/demo && /usr/bin/cmake -P /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/_yarp_idl_/placeSharedData.cmake

bits/include/SharedData.h: bits/SharedData_msg.cmake

SharedData_msg: CMakeFiles/SharedData_msg
SharedData_msg: bits/SharedData_msg.cmake
SharedData_msg: bits/include/SharedData.h
SharedData_msg: CMakeFiles/SharedData_msg.dir/build.make
.PHONY : SharedData_msg

# Rule to build all files generated by this target.
CMakeFiles/SharedData_msg.dir/build: SharedData_msg
.PHONY : CMakeFiles/SharedData_msg.dir/build

CMakeFiles/SharedData_msg.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/SharedData_msg.dir/cmake_clean.cmake
.PHONY : CMakeFiles/SharedData_msg.dir/clean

CMakeFiles/SharedData_msg.dir/depend:
	cd /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/iit/src/yarp/src/idls/rosmsg/tests/demo /opt/iit/src/yarp/src/idls/rosmsg/tests/demo /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build /opt/iit/src/yarp/src/idls/rosmsg/tests/demo/build/CMakeFiles/SharedData_msg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/SharedData_msg.dir/depend

