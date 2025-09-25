Shopping Cart APK

Files
- shopping_cart_v1.apk — release APK built from this repository (located in this folder)

Install instructions (Android)
1. On the target Android device, enable installation from unknown sources if required. Settings path varies by Android version (e.g., Settings → Security → Install unknown apps).
2. Copy `shopping_cart_v1.apk` to the device via USB, ADB, or cloud storage.
3. On the device, locate the APK (Files app) and tap to install.
4. Follow prompts and grant permissions if requested.

Install via adb (developer only):

```powershell
adb install -r build_outputs\apk\shopping_cart_v1.apk
```

Notes
- The APK was built with Flutter's `flutter build apk --release` from the current repository state.
- If installation fails due to permission or SDK mismatch, ensure the device supports the APK's ABI (x86/arm variants). This build produced a universal APK.
- For Play Store distribution, sign the app with a release key and produce an AAB.
