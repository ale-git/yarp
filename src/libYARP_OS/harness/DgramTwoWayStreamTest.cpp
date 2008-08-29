// -*- mode:C++; tab-width:4; c-basic-offset:4; indent-tabs-mode:nil -*-

/*
 * Copyright (C) 2008 Paul Fitzpatrick
 * CopyPolicy: Released under the terms of the GNU GPL v2.0.
 *
 */

#include <yarp/DgramTwoWayStream.h>
#include <yarp/String.h>
#include <yarp/UnitTest.h>
#include <yarp/NetType.h>

using namespace yarp;
using namespace yarp::os;

#define MAX_PACKET 20

class DgramTest : public DgramTwoWayStream {
public:
    ManagedBytes store[MAX_PACKET];
    int cursor;
    int readCursor;

    DgramTest() {
        cursor = 0;
        readCursor = 0;
    }

    virtual void onMonitorInput() {
        //printf("Waiting for input %d %d\n", readCursor, cursor);
        removeMonitor();
        if (readCursor<=cursor) {
            setMonitor(store[readCursor].bytes());
            //printf("Gave input of size %d\n", getMonitor().length());
            readCursor++;
        }
    }

    virtual void onMonitorOutput() {
        if (cursor<MAX_PACKET) {
            store[cursor] = ManagedBytes(getMonitor(),false);
            store[cursor].copy();
        } else {
            printf("message too big\n");
            exit(1);
        }
        cursor++;
        removeMonitor();
    }

    int size() {
        return cursor;
    }

    void clear() {
        cursor = 0;
    }

    Bytes get(int i) {
        return store[i].bytes();
    }

    void copyMonitor(DgramTest& alt) {
        cursor = alt.cursor;
        readCursor = 0;
        for (int i=0; i<cursor; i++) {
            store[i] = ManagedBytes(alt.get(i),false);
            store[i].copy();
        }
        removeMonitor();
    }
};

class DgramTwoWayStreamTest : public yarp::UnitTest {
public:
    virtual yarp::String getName() { return "DgramTwoWayStreamTest"; }

    void checkNormal() {
        report(0, "checking that normal messages get through");

        DgramTest out;

        int sz = 100;
        out.openMonitor(sz,sz);

        ManagedBytes msg(1000);
        for (int i=0; i<msg.length(); i++) {
            msg.get()[i] = i%128;
        }
        out.beginPacket();
        out.write(msg.bytes());
        out.flush();
        out.endPacket();
        printf("created %d packets\n", out.size());
        checkEqual(11,out.size(),"right number of packets");

        DgramTest in;
        in.openMonitor(sz,sz);
        ManagedBytes recv(1000);
        for (int i=0; i<recv.length(); i++) {
            recv.get()[i] = 0;
        }
        in.beginPacket();
        in.copyMonitor(out);
        NetType::readFull(in,recv.bytes());
        bool mismatch = false;
        for (int i=0; i<recv.length(); i++) {
            if (recv.get()[i]!=msg.get()[i]) {
                printf("Mismatch, at least as early as byte %d\n", i);
                mismatch = true;
                break;
            }
        }
        checkFalse(mismatch,"received what is sent");
        in.endPacket();

    }

    virtual void runTests() {
        checkNormal();
    }
};

static DgramTwoWayStreamTest theDgramTwoWayStreamTest;

yarp::UnitTest& getDgramTwoWayStreamTest() {
    return theDgramTwoWayStreamTest;
}

