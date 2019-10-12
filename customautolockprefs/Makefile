include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = customautolockprefs

customautolockprefs_FILES = calRootListController.m
customautolockprefs_INSTALL_PATH = /Library/PreferenceBundles
customautolockprefs_FRAMEWORKS = UIKit
customautolockprefs_PRIVATE_FRAMEWORKS = Preferences
customautolockprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/customautolockprefs.plist$(ECHO_END)
