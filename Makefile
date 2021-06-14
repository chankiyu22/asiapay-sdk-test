.PHONY: clean
clean:
	rm -rf output

.PHONY: without-compile-bitcode-export-options-plist
without-compile-bitcode-export-options-plist:
	/usr/libexec/PlistBuddy -c Clear _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add method string enterprise" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add signingStyle string manual" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add provisioningProfiles dict" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add provisioningProfiles:$(APP_ID) string $(PROVISIONING_PROFILE)" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add compileBitcode bool false" _ExportOptions.plist

.PHONY: normal-export-options-plist
normal-export-options-plist:
	/usr/libexec/PlistBuddy -c Clear _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add method string enterprise" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add signingStyle string manual" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add provisioningProfiles dict" _ExportOptions.plist
	/usr/libexec/PlistBuddy -c "Add provisioningProfiles:$(APP_ID) string $(PROVISIONING_PROFILE)" _ExportOptions.plist

.PHONY: exportarchive
exportarchive:
	$(MAKE) clean
	xcodebuild -sdk iphoneos -workspace "AsiaPay SDK Test.xcworkspace" -scheme "AsiaPay SDK Test" clean DSTROOT=output/build/build.dst OBJROOT=output/build/build.obj SYMROOT=output/build/build.sym SHARED_PRECOMPS_DIR=output/build/build.pch CODE_SIGN_STYLE=Manual
	xcodebuild -workspace "AsiaPay SDK Test.xcworkspace" -scheme "AsiaPay SDK Test" archive -sdk iphoneos -archivePath "output/build/archive/AsiaPay SDK Test" CODE_SIGN_STYLE=Manual
	xcodebuild -exportArchive -archivePath "output/build/archive/AsiaPay SDK Test.xcarchive" -exportPath "output/build/export/_XcodeTaskExport_AsiaPay SDK Test" -exportOptionsPlist _ExportOptions.plist
