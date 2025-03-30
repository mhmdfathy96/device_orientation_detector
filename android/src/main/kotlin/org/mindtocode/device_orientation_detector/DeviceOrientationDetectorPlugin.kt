package org.mindtocode.device_orientation_detector

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

class DeviceOrientationDetectorPlugin : FlutterPlugin, SensorEventListener {
  private lateinit var sensorManager: SensorManager
  private var accelerometer: Sensor? = null
  private var eventSink: EventChannel.EventSink? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    val channel = EventChannel(binding.binaryMessenger, "device_orientation_plugin")
    channel.setStreamHandler(
            object : EventChannel.StreamHandler {
              override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                eventSink = sink
                sensorManager =
                        binding.applicationContext.getSystemService(Context.SENSOR_SERVICE) as
                                SensorManager
                accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
                sensorManager.registerListener(
                        this@DeviceOrientationDetectorPlugin,
                        accelerometer,
                        SensorManager.SENSOR_DELAY_UI
                )
              }

              override fun onCancel(arguments: Any?) {
                sensorManager.unregisterListener(this@DeviceOrientationDetectorPlugin)
                eventSink = null
              }
            }
    )
  }

  override fun onSensorChanged(event: SensorEvent?) {
    if (event == null) return

    val x = event.values[0] // Tilt on X-axis
    val y = event.values[1] // Tilt on Y-axis
    val newOrientation: String =
            if (kotlin.math.abs(x) > kotlin.math.abs(y)) {
              "landscape"
            } else {
              "portrait"
            }
    // ✅ Send update **only if orientation changed**
    if (newOrientation != lastOrientation) {
      lastOrientation = newOrientation
      eventSink?.success(newOrientation)
    }
  }

  private var lastOrientation: String? = null // Store last detected orientation

  override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    sensorManager.unregisterListener(this)
  }
}
