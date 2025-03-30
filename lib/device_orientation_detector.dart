import 'dart:async';

import 'package:device_orientation_detector/device_orientation_detector_platform_interface.dart';

class DeviceOrientationPlugin {
  static final DeviceOrientationPlugin _instance = DeviceOrientationPlugin._();

  DeviceOrientationPlugin._();

  static DeviceOrientationPlugin get instance => _instance;
  Stream<String> get orientationStream {
    return DeviceOrientationDetectorPlatform.instance.orientationStream;
  }

  Future<void> dispose() async {
    await DeviceOrientationDetectorPlatform.instance.dispose();
  }
}
