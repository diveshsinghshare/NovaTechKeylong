import 'package:flutter/material.dart';

// ----------------------- Gentle Note Screen -----------------------

class GentleNoteScreen extends StatefulWidget {
  @override
  _GentleNoteScreenState createState() => _GentleNoteScreenState();
}

class _GentleNoteScreenState extends State<GentleNoteScreen> {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave a Note", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Leave a gentle note on your way out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 20),
            Center(child: Icon(Icons.handshake, size: 60, color: Colors.grey)),
            SizedBox(height: 20),
            TextField(
              controller: noteController,
              maxLength: 120,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write a kind note...",
                filled: true,
                fillColor: Colors.purple.shade50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 10),
            Text("💡 Ghosting is the #1 reason users feel emotionally unsafe on dating apps. You can change that with one kind note",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text("Continue", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
