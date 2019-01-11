NAME = adb
SOURCES = adb.cpp\
    adb_io.cpp\
    adb_listeners.cpp\
    adb_trace.cpp\
    adb_unique_fd.cpp\
    adb_utils.cpp\
    fdevent.cpp\
    services.cpp\
    sockets.cpp\
    socket_spec.cpp\
    sysdeps/errno.cpp\
    transport.cpp\
    transport_fd.cpp\
    transport_local.cpp\
    transport_usb.cpp\
    sysdeps_unix.cpp\
    sysdeps/posix/network.cpp\
    client/auth.cpp\
    client/usb_libusb.cpp\
    client/usb_dispatch.cpp\
    client/transport_mdns.cpp\
    client/fastdeploy.cpp\
    client/fastdeploycallbacks.cpp
CXX=eg++

SOURCES := $(foreach source, $(SOURCES), adb/$(source))
CXXFLAGS += -std=c++14 -fpermissive
CPPFLAGS += -Iinclude -Iadb -Ibase/include \
            -DADB_REVISION='"$(DEB_VERSION)"' -DADB_HOST=1 -D_GNU_SOURCE
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android -Wl,-rpath-link=. \
           -lpthread -L. -ladb -lbase -lcutils

build: $(SOURCES)
	$(CXX) $^ -o adb/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) adb/$(NAME)
