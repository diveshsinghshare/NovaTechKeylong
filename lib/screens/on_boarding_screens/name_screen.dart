// name_screen.dart

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:novatech/welcome.dart';
import '../../models/profile_singlaton.dart';
import 'gender_screen.dart';
class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _controller = TextEditingController();

  void _onContinue() {
    if (_controller.text.trim().isNotEmpty) {
      ProfileSingleton.instance.name =  _controller.text;

      Navigator.push(context, MaterialPageRoute(builder: (_) => GenderScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your name")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(color: Colors.black), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Tell us your name, we’d love to know you", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("It’s the one thing you can’t edit later."),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Enter your name",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: _onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6D4376),
              padding: EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
          ),
        ]),
      ),
    );
  }
}
// welcome_screen.dart

