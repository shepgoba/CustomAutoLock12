INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG=0
FINAL_PACKAGE=1
export TARGET = iphone:clang:11.2:11.0
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomAutoLock12

CustomAutoLock12_FILES = CustomAutoLock12.xm
CustomAutoLock12_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += customautolockprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
