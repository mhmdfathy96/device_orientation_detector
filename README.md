# Device Orientation Detector

A Flutter plugin that detects **device orientation changes** using native **Android & iOS sensors**—even when the app is locked to portrait mode! 🚀

## ✨ Features
✅ Detects **portrait** & **landscape** mode using accelerometer & motion sensors.  
✅ Works even when **screen rotation is locked**.  
✅ **Lightweight & efficient**—doesn't drain battery.  
✅ **No special permissions required** on Android or iOS.  

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  device_orientation_detector: ^1.0.1
```

Then, run:
```sh
flutter pub get
```

## 🚀 Usage

```dart
import 'package:device_orientation_detector/device_orientation_detector.dart';

void main() {
  DeviceOrientationDetector().onOrientationChanged.listen((orientation) {
    print('Orientation: $orientation'); // "portrait" or "landscape"
  });
}
```

## 📱 Platform Support
✔ **Android** (Uses `SensorManager`)  
✔ **iOS** (Uses `CoreMotion`)  

## 🛠️ How It Works
- On **Android**, it uses the **accelerometer sensor** to determine the device's tilt.
- On **iOS**, it uses **CoreMotion** to read the device's attitude and detect orientation.
- Even when **screen rotation is locked**, this plugin detects orientation changes.

## 📝 License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

