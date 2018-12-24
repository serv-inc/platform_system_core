NAME = libbase
SOURCES = file.cpp \
          logging.cpp \
          parsenetaddress.cpp \
          stringprintf.cpp \
          strings.cpp \
          errors_unix.cpp
SOURCES := $(foreach source, $(SOURCES), base/$(source))
CXXFLAGS += -std=gnu++11
CPPFLAGS += -Iinclude -Ibase/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android -L. -llog

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*