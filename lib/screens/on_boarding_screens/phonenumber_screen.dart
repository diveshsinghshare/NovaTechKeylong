import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart';
class PhoneNumberScreen extends StatefulWidget {
  final bool isSignUp; // true = signup, false = signin

  const PhoneNumberScreen({super.key, required this.isSignUp});

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _getOtp() async {
    String phone = "9590456473"; // use _phoneController.text.trim() in real case
    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final startTime = DateTime.now();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        timeout: const Duration(seconds: 60),

        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },

        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },

        codeSent: (String verificationId, int? resendToken) async {
          // ensure at least 2 seconds loader
          final elapsed = DateTime.now().difference(startTime);
          if (elapsed < const Duration(seconds: 2)) {
            await Future.delayed(const Duration(seconds: 2)) ;
          }

          if (!mounted) return;

          setState(() => _isLoading = false);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                phoneNumber: phone,
                isSignUp: widget.isSignUp,
                verificationId: verificationId,
              ),
            ),
          );
        },

        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending OTP: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    widget.isSignUp
                        ? "Let’s get your\naccount started"
                        : "Welcome back!\nEnter your number",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/india_flag.jpg', height: 18),
                            SizedBox(width: 8),
                            Text("+91"),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "9999999999",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _getOtp,
                      child: Text("Get OTP", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6B4668),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loader overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
