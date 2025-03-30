import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_orientation_detector_platform_interface.dart';

/// An implementation of [DeviceOrientationDetectorPlatform] that uses method channels.
class MethodChannelDeviceOrientationDetector
    extends DeviceOrientationDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  EventChannel channel = EventChannel('device_orientation_plugin');

  Stream<String>? _orientationStream;

  @override
  Stream<String> get orientationStream {
    _orientationStream ??= channel.receiveBroadcastStream().map(
      (event) => event as String,
    ); // Ensure type safety
    return _orientationStream!;
  }

  @override
  Future<void> dispose() async {
    _orientationStream = null;
  }
}
