import 'package:flutter/material.dart';

class BlockReportScreen extends StatefulWidget {
  @override
  _BlockReportScreenState createState() => _BlockReportScreenState();
}

class _BlockReportScreenState extends State<BlockReportScreen> {
  String? selectedReason;
  bool reportUser = false;

  final List<Map<String, String>> reasons = [
    {"title": "Inappropriate or Disrespectful", "subtitle": "Harassment, overly sexual remarks, bullying, mocking tone"},
    {"title": "Emotionally Unkind", "subtitle": "Gaslighting, guilt-tripping, passive-aggressive, manipulation"},
    {"title": "Felt Unsafe", "subtitle": "Coercion, aggressive tone, unwanted contact, pushed past consent"},
    {"title": "Fake or Misleading Profile", "subtitle": "Didn’t seem real, impersonation, or underage"},
    {"title": "Spam or Scam", "subtitle": "Unsolicited links, sketchy vibes, promotions"},
    {"title": "Off-Nova Behaviour", "subtitle": "Uncomfortable behaviour off app, call, social, or real life"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Block User", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Can you share why you'd like to block this person?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: reasons.map((reason) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedReason = reason["title"];
                      });
                    },
                    child: Card(
                      color: selectedReason == reason["title"] ? Colors.purple.shade50 : Colors.white,
                      child: ListTile(
                        title: Text(reason["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(reason["subtitle"]!),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: reportUser,
                  onChanged: (val) {
                    setState(() {
                      reportUser = val ?? false;
                    });
                  },
                ),
                Text("Do you want to report this user?"),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: selectedReason == null ? null : () {},
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
