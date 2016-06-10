#!/usr/bin/env sh
#   Script to generate all required files from fresh git checkout.

# Debian and Ubuntu do not shipt libtool anymore, but OSX does not ship libtoolize.
command -v libtoolize >/dev/null 2>&1
if  [ $? -ne 0 ]; then
    command -v libtool >/dev/null 2>&1
    if  [ $? -ne 0 ]; then
        echo "autogen.sh: error: could not find libtool.  libtool is required to run autogen.sh." 1>&2
        exit 1
    fi
fi

command -v autoreconf >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "autogen.sh: error: could not find autoreconf.  autoconf and automake are required to run autogen.sh." 1>&2
    exit 1
fi

command -v pkg-config >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "autogen.sh: error: could not find pkg-config.  pkg-config is required to run autogen.sh." 1>&2
    exit 1
fi

mkdir -p ./config
if [ $? -ne 0 ]; then
    echo "autogen.sh: error: could not create directory: ./config." 1>&2
    exit 1
fi

autoreconf --install --force --verbose -I config
status=$?
if [ $status -ne 0 ]; then
    echo "autogen.sh: error: autoreconf exited with status $status" 1>&2
    exit 1
fi
