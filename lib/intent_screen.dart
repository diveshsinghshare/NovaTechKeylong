import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:novatech/welcome.dart';
import 'orientation_screen.dart';

class IntentScreen extends StatefulWidget {
  @override
  _IntentScreenState createState() => _IntentScreenState();
}

class _IntentScreenState extends State<IntentScreen> {
  String? selectedIntent;

  final intents = [
    {
      "label": "Exploring Vibes",
      "description": "I’m curious, just seeing where things go, not fully sure what I want yet.",
    },
    {
      "label": "In a Healing Phase",
      "description": "Taking it slow. I’ve been through something and open to soft, gentle connection.",
    },
    {
      "label": "Ready for Love",
      "description": "I’m emotionally open and ready to build a genuine romantic bond.",
    },
    {
      "label": "Long-Term Vibes",
      "description": "I’m looking for a real connection that can grow into something serious and lasting.",
    },
    {
      "label": "Marriage in Mind",
      "description": "I’m here with intention, looking for a life partner and long-term commitment.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What brings you to nova?",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 24),
                      ...intents
                          .map((item) =>
                          _buildOption(item['label']!, item['description']!))
                          .toList(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: selectedIntent == null
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OrientationScreen()),
                  );
                },
                child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedIntent == null
                      ? Colors.grey.shade300
                      : Color(0xFF6D4376),
                  foregroundColor:
                  selectedIntent == null ? Colors.grey : Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String title, String description) {
    final isSelected = selectedIntent == title;
    return GestureDetector(
      onTap: () => setState(() => selectedIntent = title),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Color(0xFFF2E6F5) : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
              ]),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.purple),
                color: isSelected ? Colors.purple : Colors.transparent,
              ),
              child: isSelected ? Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}
