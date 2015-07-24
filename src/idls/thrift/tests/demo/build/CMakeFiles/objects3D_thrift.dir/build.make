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
CMAKE_SOURCE_DIR = /opt/iit/src/yarp/src/idls/thrift/tests/demo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/iit/src/yarp/src/idls/thrift/tests/demo/build

# Utility rule file for objects3D_thrift.

# Include the progress variables for this target.
include CMakeFiles/objects3D_thrift.dir/progress.make

CMakeFiles/objects3D_thrift: objects3D_thrift.cmake

objects3D_thrift.cmake: ../objects3D.thrift
	$(CMAKE_COMMAND) -E cmake_progress_report /opt/iit/src/yarp/src/idls/thrift/tests/demo/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating objects3D_thrift.cmake, include/PointXYZ.h, include/Polygon.h, include/RGBA.h, include/SurfaceMesh.h, include/Box3D.h, include/SurfaceMeshWithBoundingBox.h, src/PointXYZ.cpp, src/Polygon.cpp, src/RGBA.cpp, src/SurfaceMesh.cpp, src/Box3D.cpp, src/SurfaceMeshWithBoundingBox.cpp"
	cd /opt/iit/src/yarp/src/idls/thrift/tests/demo && /opt/iit/build/yarp/bin/yarpidl_thrift --out /opt/iit/src/yarp/src/idls/thrift/tests/demo/build/_yarp_idl_/objects3d --gen yarp:include_prefix --I /opt/iit/src/yarp/src/idls/thrift/tests/demo objects3D.thrift
	cd /opt/iit/src/yarp/src/idls/thrift/tests/demo && /usr/bin/cmake -P /opt/iit/src/yarp/src/idls/thrift/tests/demo/build/_yarp_idl_/objects3d/placeobjects3D.cmake

include/PointXYZ.h: objects3D_thrift.cmake

include/Polygon.h: objects3D_thrift.cmake

include/RGBA.h: objects3D_thrift.cmake

include/SurfaceMesh.h: objects3D_thrift.cmake

include/Box3D.h: objects3D_thrift.cmake

include/SurfaceMeshWithBoundingBox.h: objects3D_thrift.cmake

src/PointXYZ.cpp: objects3D_thrift.cmake

src/Polygon.cpp: objects3D_thrift.cmake

src/RGBA.cpp: objects3D_thrift.cmake

src/SurfaceMesh.cpp: objects3D_thrift.cmake

src/Box3D.cpp: objects3D_thrift.cmake

src/SurfaceMeshWithBoundingBox.cpp: objects3D_thrift.cmake

objects3D_thrift: CMakeFiles/objects3D_thrift
objects3D_thrift: objects3D_thrift.cmake
objects3D_thrift: include/PointXYZ.h
objects3D_thrift: include/Polygon.h
objects3D_thrift: include/RGBA.h
objects3D_thrift: include/SurfaceMesh.h
objects3D_thrift: include/Box3D.h
objects3D_thrift: include/SurfaceMeshWithBoundingBox.h
objects3D_thrift: src/PointXYZ.cpp
objects3D_thrift: src/Polygon.cpp
objects3D_thrift: src/RGBA.cpp
objects3D_thrift: src/SurfaceMesh.cpp
objects3D_thrift: src/Box3D.cpp
objects3D_thrift: src/SurfaceMeshWithBoundingBox.cpp
objects3D_thrift: CMakeFiles/objects3D_thrift.dir/build.make
.PHONY : objects3D_thrift

# Rule to build all files generated by this target.
CMakeFiles/objects3D_thrift.dir/build: objects3D_thrift
.PHONY : CMakeFiles/objects3D_thrift.dir/build

CMakeFiles/objects3D_thrift.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/objects3D_thrift.dir/cmake_clean.cmake
.PHONY : CMakeFiles/objects3D_thrift.dir/clean

CMakeFiles/objects3D_thrift.dir/depend:
	cd /opt/iit/src/yarp/src/idls/thrift/tests/demo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/iit/src/yarp/src/idls/thrift/tests/demo /opt/iit/src/yarp/src/idls/thrift/tests/demo /opt/iit/src/yarp/src/idls/thrift/tests/demo/build /opt/iit/src/yarp/src/idls/thrift/tests/demo/build /opt/iit/src/yarp/src/idls/thrift/tests/demo/build/CMakeFiles/objects3D_thrift.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/objects3D_thrift.dir/depend

