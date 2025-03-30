import 'package:device_orientation_detector/device_orientation_detector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OrientationListener());
  }
}

class OrientationListener extends StatefulWidget {
  const OrientationListener({super.key});
  @override
  State<OrientationListener> createState() => _OrientationListenerState();
}

class _OrientationListenerState extends State<OrientationListener> {
  String _orientation = "portrait";

  @override
  void initState() {
    super.initState();
    DeviceOrientationPlugin.instance.orientationStream.listen((orientation) {
      setState(() {
        _orientation = orientation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Device Orientation Detector")),
      body: Center(
        child: Text(
          "Current Orientation: $_orientation",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
