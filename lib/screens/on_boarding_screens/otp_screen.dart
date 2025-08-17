import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../homescreen.dart';
import '../../models/profile_singlaton.dart';
import '../../services/profile_service.dart';
import '../../services/verify_token_service.dart';
import 'birthday_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isSignUp;
  final String verificationId;

  const OTPScreen({
    Key? key,
    required this.phoneNumber,
    required this.isSignUp,
    required this.verificationId,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {



  Future<void> loadProfile() async {
    final profile = await ProfileService.fetchProfile(); // from earlier method we wrote

    if (profile != null) {
      print("Profile loaded: ${profile}, ${profile}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print("❌ Failed to load profile");
    }
  }

  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;

  Future<void> _submitOtp() async {
    String otp = _otpControllers.map((e) => e.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit OTP')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Create credential with OTP and verificationId
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      // Sign in the user with the credential
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the ID token (Bearer token)
      String? idToken = await userCredential.user?.getIdToken();
      print("Bearer Token: $idToken");
      ProfileSingleton.instance.token = idToken!;

      // Verify token from backend
      final userData = await AuthService.verifyToken(idToken!);
      if (userData != null) {
        print("User ID: ${userData['user_id']}");
        print("Phone: ${userData['phone']}");

        // Save to ProfileSingleton
        ProfileSingleton.instance.user_id = userData['user_id'];
        ProfileSingleton.instance.phoneNumber = userData['phone'];

        // Navigate based on sign up / login
        if (widget.isSignUp) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BirthdayScreen()),
          );
        } else {

         loadProfile();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid or expired token")),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "OTP verification failed";
      if (e.code == 'invalid-verification-code') {
        errorMessage = "Invalid OTP. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> saveVerificationIdToFile(String verificationId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/verification_id.txt');
      await file.writeAsString(verificationId);
      print("Verification ID saved to: ${file.path}");
    } catch (e) {
      print("Error saving verification ID: $e");
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 12),
              const Text(
                "Let’s make sure it’s really you",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "Please enter the 6-digit verification code sent to\n${widget.phoneNumber}",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          } else {
                            _focusNodes[index].unfocus();
                          }
                        } else if (index > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index - 1]);
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Text("Enter code within 01:48"),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B4668),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
