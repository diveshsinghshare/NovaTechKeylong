import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'homescreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/handshake.jpg', height: 200), // Replace with your asset
          SizedBox(height: 32),
          Text("Welcome to Nova!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            "30% complete, and already interesting\nFinish your profile so Nova can tune into your real vibe",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );

            }, // continue flow

            child: Text(
              "Continue Building Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6D4376),
              padding: EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            child: Text("Nova Preview"),
            style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              side: BorderSide(color: Color(0xFF6D4376)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          SizedBox(height: 12),
          Text("Note: You can always complete your profile later", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ]),
      ),
    );
  }
}
// gender_screen.dart
