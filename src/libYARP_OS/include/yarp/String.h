// -*- mode:C++; tab-width:4; c-basic-offset:4; indent-tabs-mode:nil -*-

/*
 * Copyright (C) 2006 Paul Fitzpatrick
 * CopyPolicy: Released under the terms of the GNU GPL v2.0.
 *
 */

#ifndef _YARP2_STRING_
#define _YARP2_STRING_

#include <ace/String_Base.h>

namespace yarp {
    typedef ACE_String_Base<char> String;
}

namespace yarp {
    namespace os {
        namespace impl {
            using yarp::String;
        }
    }
}

//#undef main //undef ace floating defines

#endif

