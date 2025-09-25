
# Shopping Cart (Flutter + Riverpod)

A small shopping/cart demo built with Flutter and Riverpod. It loads product data from a local JSON file, keeps cart state persisted with Shared Preferences, and demonstrates a simple checkout flow with custom UI polish (golden gradients, confirmation dialog).


Key features
- Product listing (from `assets/products.json`)
- Product detail screen with Add to Cart
- Cart screen with increment / decrement / remove
- Checkout screen with confirmation dialog and delivery info
- Cart persistence across app restarts using `shared_preferences`

Prerequisites
- Flutter SDK (tested with Flutter 3.24.x / stable)
- Android SDK / platform tools (for building APK)

Quick start (run locally)
1. Clone the repository and open it in your IDE/VS Code:

```powershell
git clone https://github.com/<your-username>/Shopping-cart.git
cd Shopping-cart
flutter pub get
```

2. Run on an emulator or device:

```powershell
flutter run
```

Build a release APK
1. Build a universal release APK:

```powershell
flutter build apk --release
```

2. The generated APK will be placed at:
```
build\app\outputs\flutter-apk\app-release.apk
```

Pre-bundled APK (in this repo)
- A release APK has been copied to `build_outputs/apk/shopping_cart_v1.apk` for convenience.
- Install on an Android device via ADB:

```powershell
adb install -r build_outputs\apk\shopping_cart_v1.apk
```

Or copy the APK to the device and install via the Files app.

Project structure
- `lib/` — app source
	- `main.dart` — app entry and routes
	- `screens/` — product list, product detail, cart, checkout
	- `widgets/` — small reusable widgets (cart badge, tiles)
	- `models/` — `product`, `cart_item`
	- `providers/` — `product_provider` (JSON load) and `cart_provider` (persistence)
- `assets/products.json` — product data used by the app
- `build_outputs/` — contains the prebuilt APK and install README

Testing & analysis
- The project uses lint rules from `flutter_lints`. Run analyzer:

```powershell
flutter analyze
```
---
Generated: ${DateTime.now()}
