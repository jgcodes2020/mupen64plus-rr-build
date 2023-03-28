# Mupen64Plus-RR master build for all libraries.
# ==============================================

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
root_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
api_dir := $(root_dir)/install/include/mupen64plus
api_headers := \
	install/include/mupen64plus/m64p_common.h \
	install/include/mupen64plus/m64p_config.h \
	install/include/mupen64plus/m64p_debugger.h \
	install/include/mupen64plus/m64p_encoder.h \
	install/include/mupen64plus/m64p_frontend.h \
	install/include/mupen64plus/m64p_plugin.h \
	install/include/mupen64plus/m64p_types.h \
	install/include/mupen64plus/m64p_vcr.h \
	install/include/mupen64plus/m64p_vidext.h

include makefiles/atomic.mk

.PHONY: clean all

all: install/lib/libmupen64plus.so.2 \
install/lib/mupen64plus/mupen64plus-video-rice.so \
install/lib/mupen64plus/mupen64plus-video-glide64mk2.so \
install/lib/mupen64plus/mupen64plus-audio-sdl.so \
install/lib/mupen64plus/mupen64plus-input-sdl.so \
install/lib/mupen64plus/mupen64plus-rsp-hle.so

$(call ATOMIC, install/lib/libmupen64plus.so.2 $(api_headers)):
	$(MAKE) -C mupen64plus-core-rr/projects/unix all VCR_SUPPORT=1 ENC_SUPPORT=1 PREFIX=$(root_dir)/install
	$(MAKE) -C mupen64plus-core-rr/projects/unix install PREFIX=$(root_dir)/install

install/lib/mupen64plus/mupen64plus-video-rice.so: $(api_headers)
	$(MAKE) -C mupen64plus-video-rice/projects/unix all PREFIX=$(root_dir)/install APIDIR=$(api_dir)
	$(MAKE) -C mupen64plus-video-rice/projects/unix install PREFIX=$(root_dir)/install

install/lib/mupen64plus/mupen64plus-video-glide64mk2.so: $(api_headers)
	$(MAKE) -C mupen64plus-video-glide64mk2/projects/unix all PREFIX=$(root_dir)/install APIDIR=$(api_dir)
	$(MAKE) -C mupen64plus-video-glide64mk2/projects/unix install PREFIX=$(root_dir)/install

install/lib/mupen64plus/mupen64plus-audio-sdl.so: $(api_headers)
	$(MAKE) -C mupen64plus-audio-sdl/projects/unix all PREFIX=$(root_dir)/install APIDIR=$(api_dir)
	$(MAKE) -C mupen64plus-audio-sdl/projects/unix install PREFIX=$(root_dir)/install

install/lib/mupen64plus/mupen64plus-input-sdl.so: $(api_headers)
	$(MAKE) -C mupen64plus-input-sdl/projects/unix all PREFIX=$(root_dir)/install APIDIR=$(api_dir)
	$(MAKE) -C mupen64plus-input-sdl/projects/unix install PREFIX=$(root_dir)/install

install/lib/mupen64plus/mupen64plus-rsp-hle.so: $(api_headers)
	$(MAKE) -C mupen64plus-rsp-hle/projects/unix all PREFIX=$(root_dir)/install APIDIR=$(api_dir)
	$(MAKE) -C mupen64plus-rsp-hle/projects/unix install PREFIX=$(root_dir)/install

clean:
	rm -rf $(root_dir)/install/*
	$(MAKE) -C mupen64plus-core-rr/projects/unix clean
	$(MAKE) -C mupen64plus-video-rice/projects/unix clean
	$(MAKE) -C mupen64plus-video-glide64mk2/projects/unix clean
	$(MAKE) -C mupen64plus-audio-sdl/projects/unix clean
	$(MAKE) -C mupen64plus-input-sdl/projects/unix clean
	$(MAKE) -C mupen64plus-rsp-hle/projects/unix clean