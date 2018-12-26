NAME = liblog
# SOURCES copied from Android.bp
SOURCES =  config_read.c\
    config_write.c\
    local_logger.c\
    log_event_list.c\
    log_event_write.c\
    log_ratelimit.cpp\
    logger_lock.c\
    logger_name.c\
    logger_read.c\
    logger_write.c\
    logprint.c\
    stderr_write.c
SOURCES := $(foreach source, $(SOURCES), liblog/$(source))
CFLAGS += -fvisibility=hidden -fPIC
CPPFLAGS += -Iinclude \
            -DLIBLOG_LOG_TAG=1005 \
            -DFAKE_LOG_DEVICE=1 \
            -DSNET_EVENT_LOG_TAG=1397638484 \
            -std=gnu++11
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 -lpthread

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*
