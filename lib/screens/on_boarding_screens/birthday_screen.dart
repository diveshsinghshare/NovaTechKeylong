
// birthday_screen.dart

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:novatech/welcome.dart';
import 'interested_screen.dart';
import 'location_screen.dart';
import '../../models/profile_singlaton.dart';

class BirthdayScreen extends StatefulWidget {
  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  DateTime? selectedDate;

  void _confirmAge(int age) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("You're $age"),
        content: Text("Take a sec to confirm your age, once it's in, it stays. You’ve got this"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Edit")),
          TextButton(
            onPressed: () {

              final now = DateTime.now();
              final birthYear = now.year - age;
              ProfileSingleton.instance.dob =
                  DateTime(birthYear, now.month, now.day).toIso8601String();
              Navigator.pop(ctx);
              Navigator.push(context, MaterialPageRoute(builder: (_) => LocationScreen()));
            },
            child: Text("Confirm", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
      final age = DateTime.now().year - picked.year;
      _confirmAge(age);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(color: Colors.black), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("What's your birthday?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          GestureDetector(
            onTap: _pickBirthday,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                selectedDate == null ? "Select your birthday" : DateFormat('MMMM dd, yyyy').format(selectedDate!),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

