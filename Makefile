.PHONY: run xcframework

# Allow overriding common build knobs.
CONFIG ?= Release
DESTINATION ?= generic/platform=iOS
DERIVED_DATA ?= $(CURDIR)/build/xcodebuild
WORKSPACE ?= .swiftpm/xcode/package.xcworkspace
SCHEME ?= SwiftGodotAppleTemplate
FRAMEWORK_NAME ?= SwiftGodotAppleTemplate
XCFRAMEWORK ?= $(CURDIR)/addons/$(FRAMEWORK_NAME)/bin/$(FRAMEWORK_NAME).xcframework
XCODEBUILD ?= xcodebuild

IOS_DEVICE_FRAMEWORK := $(DERIVED_DATA)/Build/Products/$(CONFIG)-iphoneos/PackageFrameworks/$(FRAMEWORK_NAME).framework
IOS_SIM_FRAMEWORK := $(DERIVED_DATA)/Build/Products/$(CONFIG)-iphonesimulator/PackageFrameworks/$(FRAMEWORK_NAME).framework

run:
	@set -e; \
	$(XCODEBUILD) \
		-workspace '$(WORKSPACE)' \
		-scheme '$(SCHEME)' \
		-configuration '$(CONFIG)' \
		-destination '$(DESTINATION)' \
		-derivedDataPath '$(DERIVED_DATA)' \
		build

xcframework:
	@set -e; \
	mkdir -p addons/SwiftGodotAppleTemplate/bin/; \
	for dest in "generic/platform=iOS" "generic/platform=iOS Simulator"; do \
		$(XCODEBUILD) \
			-workspace '$(WORKSPACE)' \
			-scheme '$(SCHEME)' \
			-configuration '$(CONFIG)' \
			-destination "$$dest" \
			-derivedDataPath '$(DERIVED_DATA)' \
			build; \
	done; \
	rm -rf '$(XCFRAMEWORK)'; \
	$(XCODEBUILD) -create-xcframework \
		-framework '$(IOS_DEVICE_FRAMEWORK)' \
		-framework '$(IOS_SIM_FRAMEWORK)' \
		-output '$(XCFRAMEWORK)'

q:
	rm -rf '$(XCFRAMEWORK)'; \
	$(XCODEBUILD) -create-xcframework \
		-framework ~/DerivedData/SwiftGodotAppleTemplate-*/Build/Products/Debug-iphoneos/PackageFrameworks/SwiftGodotAppleTemplate.framework/ \
		-output '$(XCFRAMEWORK)'

