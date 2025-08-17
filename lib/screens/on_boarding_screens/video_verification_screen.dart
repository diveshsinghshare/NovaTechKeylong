import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:novatech/screens/on_boarding_screens/profile_verification_screen.dart';

import '../../models/profile_singlaton.dart';

class VideoVerificationScreen extends StatefulWidget {
  @override
  _VideoVerificationScreenState createState() =>
      _VideoVerificationScreenState();
}

class _VideoVerificationScreenState extends State<VideoVerificationScreen> {
  CameraController? controller;
  bool isRecording = false;
  XFile? recordedVideo; // store recorded video

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(
      cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front),
      ResolutionPreset.medium,
    );
    await controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> startStopRecording() async {
    if (controller == null || !controller!.value.isInitialized) return;

    if (!isRecording) {
      await controller!.startVideoRecording();
      setState(() => isRecording = true);
    } else {
      final file = await controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
        recordedVideo = file; // save recorded video
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Take a Selfie Video")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: recordedVideo == null
                  ? ClipOval(child: CameraPreview(controller!))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.videocam, size: 80, color: Colors.blue),
                  const SizedBox(height: 12),
                  Text(
                    "Video Recorded:\n${recordedVideo!.path.split('/').last}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Buttons
          if (recordedVideo == null)
            ElevatedButton(
              onPressed: startStopRecording,
              child: Text(isRecording ? "Stop Recording" : "Start Recording"),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // retry -> clear recorded video
                    setState(() {
                      recordedVideo = null;
                    });
                  },
                  child: const Text("Retry"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ProfileSingleton.instance.selfiVideoPath = recordedVideo!.path;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyProfileScreen(),
                      ),
                    );
                  },
                  child: const Text("Continue"),
                ),
              ],
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
