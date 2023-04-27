import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipe_manager/ui/scan/camera.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  late bool _isPermissionGranted;

  @override
  void initState() {
    _getCameraPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          if (!_isPermissionGranted) {
            await _requestCameraPermission();

            if (_isPermissionGranted) {
              navigator.push(MaterialPageRoute(
                  builder: (context) => const CameraScreen()));
            }
          } else {
            navigator.push(
                MaterialPageRoute(builder: (context) => const CameraScreen()));
          }
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: const Center(
                  child: Text('Tap to scan from camera'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCameraPermission() async {
    _isPermissionGranted = await Permission.camera.isGranted;
  }

  Future<void> _requestCameraPermission() async {
    await Permission.camera.request();
    _isPermissionGranted = await Permission.camera.isGranted;
  }
}
