#!/bin/bash

##############################################################################
#
# Copyright: (C) 2011 RobotCub Consortium
# Authors: Paul Fitzpatrick
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
#
# Download and build YARP from source
# 

BUILD_DIR=$PWD

# Get SETTINGS_* variables (paths) from cache
source ./settings.sh || {
	echo "No settings.sh found, are we in the build directory?"
	exit 1
}

# Get BUNDLE_* variables (software versions) from the bundle file
source $SETTINGS_BUNDLE_FILENAME || {
	echo "Bundle settings not found"
	exit 1
}

# GET OPT_* variables (build options) by processing our command-line options
source $SETTINGS_SOURCE_DIR/src/process_options.sh $* || {
	echo "Cannot process options"
	exit 1
}

# Pick up CMake paths
source cmake_any_any_any.sh || {
	echo "Cannot find corresponding CMAKE build"
	exit 1
}

# Pick up ACE paths
source ace_${compiler}_${variant}_${build}.sh || {
	echo "Cannot find corresponding ACE build"
	exit 1
}

# Pick up GSL paths
source gsl_${compiler}_${variant}_${build}.sh || {
	echo "Cannot find corresponding GSL build"
	exit 1
}

# Pick up GTKMM paths
source gtkmm_${compiler}_${variant}_${build}.sh || {
	echo "Cannot find corresponding GTKMM build"
	exit 1
}

# Go ahead and download YARP
fname=yarp-$BUNDLE_YARP_VERSION
if [ ! -e $fname ]; then
	if [ "k$BUNDLE_YARP_VERSION" = "ktrunk" ]; then
		svn co https://yarp0.svn.sourceforge.net/svnroot/yarp0/trunk/yarp2 $fname || {
			echo "Cannot fetch YARP"
			exit 1
		}
	else
		if [ "k$YARP_REVISION" = "k" ]; then
			svn co https://yarp0.svn.sourceforge.net/svnroot/yarp0/tags/$fname $fname || {
				echo "Cannot fetch YARP"
				exit 1
			}
		else
			svn co https://yarp0.svn.sourceforge.net/svnroot/yarp0/trunk/yarp2 -r $YARP_REVISION $fname || {
				echo "Cannot fetch YARP"
				exit 1
			}
		fi
	fi
fi

# Make and enter build directory
fname2=$fname-$OPT_COMPILER-$OPT_VARIANT-$OPT_BUILD
mkdir -p $fname2
cd $fname2 || exit 1

YARP_DIR=`cygpath --mixed "$PWD"`
YARP_ROOT=`cygpath --mixed "$PWD/../$fname"`

echo "Using ACE from $ACE_ROOT"
echo "Using GSL from $GSL_DIR"

# Set up configure and build steps.  We have to be careful for MINGW.
(
cat << XXX
	source $SETTINGS_SOURCE_DIR/src/restrict_path.sh
	"$CMAKE_BIN" $OPT_CMAKE_OPTION -DCMAKE_INSTALL_PREFIX=$YARP_DIR/install -DCREATE_YARPSERVER3=TRUE -DCREATE_LIB_MATH=TRUE -DCMAKE_LIBRARY_PATH="$GTKMM_BASEPATH/include" -DCMAKE_INCLUDE_PATH="$GTKMM_BASEPATH/include/include" -DFREETYPE_INCLUDE_DIRS="." -DFREETYPE_LIBRARIES="" -DFREETYPE_LIBRARY="" -DGSL_LIBRARY="$GSL_LIBRARY" -DGSLCBLAS_LIBRARY="$GSLCBLAS_LIBRARY" -DGSL_DIR="$GSL_DIR" -DCREATE_GUIS=TRUE -DYARP_USE_GTK2=TRUE -DCREATE_SHARED_LIBRARY=TRUE -DYARP_COMPILE_TESTS=TRUE -DYARP_FILTER_API=TRUE -G "$OPT_GENERATOR" ../$fname || exit 1
	target_name "YARP"
	$OPT_BUILDER  \$user_target \$TARGET $OPT_CONFIGURATION_COMMAND $OPT_PLATFORM_COMMAND || exit 1
	if [ ! -e install ]; then
		"$CMAKE_BIN" --build . --target install --config ${build} || exit 1
	fi
XXX
) > compile_base.sh
# Make a small compile script for user testing
(
	set
	echo 'user_target="$1"'
	echo "source compile_base.sh"
) > compile.sh

# Configure and build
{
	source compile_base.sh || exit 1
}

# Cache YARP-related paths and variables, for dependent packages to read
(
	echo "export YARP_DIR='$YARP_DIR'"
	echo "export YARP_ROOT='$YARP_ROOT'"
) > $BUILD_DIR/yarp_${compiler}_${variant}_${build}.sh
