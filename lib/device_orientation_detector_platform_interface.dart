import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_orientation_detector_method_channel.dart';

abstract class DeviceOrientationDetectorPlatform extends PlatformInterface {
  /// Constructs a DeviceOrientationDetectorPlatform.
  DeviceOrientationDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceOrientationDetectorPlatform _instance =
      MethodChannelDeviceOrientationDetector();

  /// The default instance of [DeviceOrientationDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceOrientationDetector].
  static DeviceOrientationDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceOrientationDetectorPlatform] when
  /// they register themselves.
  static set instance(DeviceOrientationDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<String> get orientationStream;
  Future<void> dispose();
}
