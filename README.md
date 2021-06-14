# AsiaPay SDK Test

## Setup

1. Create a temp app id and a distribution provisioning profile (e.g. In House) in apple developer portal. Download the provisioning profile just created.
1. Run `pod install`
1. Launch `AsiaPay SDK Test.xcworkspace` with xcode
1. Update `Bundle Identifier` and import `Provisioning Profile` fields in `TARGETS > AsiaPay SDK Test > Signing & Capabilities` in Project `AsiaPay SDK Test` with the temp app id and the provisioning profile just downloaded

## Test

### Default: With compile bitcode in export options

```sh
$ make normal-export-options-plist APP_ID="<TEMP_APP_ID>" PROVISIONING_PROFILE="<The name of the provisioning profile>"
$ make exportarchive
```

Without specifying the export option `compileBitcode: false`, the archive cannot be exported with the following error:

```
    -= Output =-
    ld: warning: -sdk_version and -platform_version are not compatible, ignoring -sdk_version
    Undefined symbols for architecture arm64:
      "_$s8Material14ErrorTextFieldC5errorSSSgvsTj", referenced from:
          __hidden#6790_ in 055.o
          __hidden#6822_ in 055.o
      "_$s8Material14ErrorTextFieldC02isB8RevealedSbvsTj", referenced from:
          __hidden#6786_ in 055.o
    ld: symbol(s) not found for architecture arm64
    Exited with 1

    Failed to compile bundle: /var/folders/c6/96b34_v17hq36rh1qrnv97fw0000gn/T/AP_PaySDKnyn8pwn7/AP_PaySDK.arm64.xar
```

### Without compile bitcode in export options

```sh
$ make without-compile-bitcode-export-options-plist APP_ID="<TEMP_APP_ID>" PROVISIONING_PROFILE="<The name of the provisioning profile>"
$ make exportarchive
```

There is an export option `compileBitcode: false` specified in `_ExportOptions.plist`.

When this special option is added to export options, the archive can be exported successfully.
