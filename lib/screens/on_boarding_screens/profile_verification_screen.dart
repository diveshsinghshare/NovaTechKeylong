import 'package:flutter/material.dart';
import 'package:novatech/homescreen.dart';
import '../../models/profile_singlaton.dart';

class VerifyProfileScreen extends StatefulWidget {
  const VerifyProfileScreen({Key? key}) : super(key: key);

  @override
  State<VerifyProfileScreen> createState() => _VerifyProfileScreenState();
}

class _VerifyProfileScreenState extends State<VerifyProfileScreen> {
  final _linkedinController = TextEditingController();
  final _instagramController = TextEditingController();

  String? _linkedinError;
  String? _instagramError;

  bool _isValidUrl(String url, String platform) {
    final pattern = platform == 'linkedin'
        ? r'^https:\/\/(www\.)?linkedin\.com\/.*$'
        : r'^https:\/\/(www\.)?instagram\.com\/.*$';
    return RegExp(pattern).hasMatch(url);
  }

  void _validateAndContinue() {
    setState(() {
      _linkedinError = _linkedinController.text.isNotEmpty &&
          !_isValidUrl(_linkedinController.text, 'linkedin')
          ? 'Hmm… that doesn’t look like a valid link. Try copying your profile URL again'
          : null;

      _instagramError = _instagramController.text.isNotEmpty &&
          !_isValidUrl(_instagramController.text, 'instagram')
          ? 'Hmm… that doesn’t look like a valid link. Try copying your profile URL again'
          : null;
    });

    // if (_linkedinError == null && _instagramError == null) {
    //   // Continue to next screen
    //   print('Continue pressed');
    //   ProfileSingleton.instance.linkedProfile = _linkedinController.text;
    //   ProfileSingleton.instance.linkedProfile = _instagramController.text;
    //
    // } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
   // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Skip', style: TextStyle(color: Colors.grey)),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify your profile to keep things real',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'It helps us build a safer space and show others you’re the real deal.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 5),
              const Text(
                'LinkedIn profile (optional)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Just for verification, never shared with anyone',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: _linkedinController,
                decoration: InputDecoration(
                  hintText: 'link',
                  errorText: _linkedinError,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Instagram profile (optional)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Just for verification, never shared with anyone',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: _instagramController,
                decoration: InputDecoration(
                  hintText: 'link',
                  errorText: _instagramError,
                ),
              ),
              const SizedBox(height: 40), // ✅ added extra space before button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _validateAndContinue,
                  child: const Text(
                    'continue',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
