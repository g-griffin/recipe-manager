import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/index.dart';
import 'package:recipe_manager/ui/scan/result.dart';
import 'package:recipe_manager/utils/errors.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  final _textRecognizer = TextRecognizer();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<CameraDescription>>(
              future: availableCameras(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _initCameraController(snapshot.data!);
                  return Center(
                    child: CameraPreview(_cameraController!),
                  );
                } else {
                  return const LinearProgressIndicator();
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.white,
            child: Center(
              child: ElevatedButton(
                onPressed: _scanImage,
                child: const Text('Scan'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startCamera() {
    if (_cameraController != null) {
      _onRearCameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  Future<void> _initCameraController(List<CameraDescription> cameras) async {
    if (_cameraController != null) {
      return;
    }
    CameraDescription? rearCamera = _getRearCamera(cameras);
    if (rearCamera != null) {
      await _onRearCameraSelected(rearCamera);
    }
  }

  CameraDescription? _getRearCamera(List<CameraDescription> cameras) {
    CameraDescription? rearCamera;
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.back) {
        rearCamera = camera;
      }
    }
    return rearCamera;
  }

  Future<void> _onRearCameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    try {
      await _cameraController?.initialize();
      if (mounted) {
        setState(() {});
      }
    } on CameraException catch (e) {
      if (e.code == 'CameraAccessDenied') {
        showInSnackBar(context, 'You have denied camera access.');
      } else {
        _showCameraException(e);
      }
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar(context, 'Error: ${e.code}\n${e.description}');
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;
    final navigator = Navigator.of(context);

    try {
      final pictureFile = await _cameraController!.takePicture();
      final file = File(pictureFile.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      await serviceLocator<DioClient>()
          .saveIndex(Index(indexText: recognizedText.text));
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(text: recognizedText.text),
        ),
      );
    } catch (e) {
      showInSnackBar(context, 'An error occurred when scanning text');
    }
  }
}
