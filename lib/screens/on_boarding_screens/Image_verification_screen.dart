import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:novatech/models/profile_singlaton.dart';
import 'package:novatech/screens/on_boarding_screens/profile_verification_screen.dart';
import 'package:novatech/screens/on_boarding_screens/video_verification_screen.dart';

class ImageVerificationScreen extends StatefulWidget {
  @override
  _ImageVerificationScreenState createState() =>
      _ImageVerificationScreenState();
}

class _ImageVerificationScreenState extends State<ImageVerificationScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isCapturing = false;
  XFile? capturedImage; // store selfie

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();

      final frontCamera = cameras!.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
      );

      controller = CameraController(frontCamera, ResolutionPreset.medium);

      await controller!.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera initialization failed")),
      );
    }
  }

  Future<void> captureSelfie() async {
    if (controller == null || !controller!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera not ready")),
      );
      return;
    }

    if (isCapturing) return; // prevent multiple taps

    try {
      setState(() => isCapturing = true);

      await Future.delayed(const Duration(milliseconds: 300));

      final file = await controller!.takePicture();
      print("Captured selfie: ${file.path}");

      if (!mounted) return;

      setState(() {
        capturedImage = file; // store the image for preview
      });
    } catch (e) {
      print("Error capturing selfie: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to capture image. Please try again.")),
        );
      }
    } finally {
      setState(() => isCapturing = false);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Take a Selfie")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: capturedImage == null
                  ? ClipOval(child: CameraPreview(controller!))
                  : ClipOval(
                child: Image.file(
                  File(capturedImage!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Show buttons conditionally
          if (capturedImage == null)
            ElevatedButton(
              onPressed: captureSelfie,
              child: const Text("Take Selfie"),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      capturedImage = null; // reset for retry
                    });
                  },
                  child: const Text("Retry"),
                ),
                ElevatedButton(
                  onPressed: () {

                    ProfileSingleton.instance.selfiImagePath = capturedImage!.path;
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
        ],
      ),
    );
  }
}
