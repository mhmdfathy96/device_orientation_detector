import Flutter
import UIKit
import CoreMotion

public class DeviceOrientationDetectorPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private let motionManager = CMMotionManager()
    private var eventSink: FlutterEventSink?
private var lastOrientation: String? = nil // Store last orientation

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "device_orientation_plugin", binaryMessenger: registrar.messenger())
        let instance = DeviceOrientationDetectorPlugin()
        channel.setStreamHandler(instance)
    }

    // ✅ Implement FlutterStreamHandler correctly
    public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        startListening()
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        motionManager.stopDeviceMotionUpdates()
        eventSink = nil
        return nil
    }

    private func startListening() {
    motionManager.deviceMotionUpdateInterval = 0.5 // Set a reasonable update interval
    motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
        guard let motion = motion else { return }

        let pitch = motion.attitude.pitch * 180 / .pi
        let roll = motion.attitude.roll * 180 / .pi

        let newOrientation: String
        if abs(roll) > abs(pitch) {
            newOrientation = "landscape"
        } else {
            newOrientation = "portrait"
        }

        // ✅ Send event only if orientation changed
        if newOrientation != self.lastOrientation {
            self.lastOrientation = newOrientation
            print("📡 Sending orientation update: \(newOrientation)") // Debug log
            self.eventSink?(newOrientation)
        }
    }
}
}

