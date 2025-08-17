import 'package:flutter/material.dart';
import 'package:novatech/screens/on_boarding_screens/phonenumber_screen.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Logo + Title
              Column(
                children: [
                  Image.asset(
                    "assets/nova_logo.jpg",
                    height: 60,
                  ),
                  SizedBox(height: 12),
                  // Text(
                  //   "nova",
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(0xFF6A4375),
                  //   ),
                  // ),
                  SizedBox(height: 4),
                  Text(
                    "Real , Respectful",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Consent Checkbox + Text
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF6A4375),
                  ),
                  Expanded(
                    child: Text(
                      "I certify that: I am at least 18 years old; and I have read and expressly consent to the Nova Privacy Policy, Terms and Conditions, and personal information I choose to share to improve my experience.",
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isChecked
                        ? const Color(0xFF6A4375)
                        : Colors.grey, // Disable when unchecked
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isChecked
                      ? () {
                    // Navigate next screen

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PhoneNumberScreen(isSignUp: true),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Consent Accepted")),
                    );
                  }
                      : null,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
