import 'package:flutter/material.dart';

// ----------------------- Unmatch Reason Screen -----------------------

class UnmatchScreen extends StatefulWidget {
  @override
  _UnmatchScreenState createState() => _UnmatchScreenState();
}

class _UnmatchScreenState extends State<UnmatchScreen> {
  String? selectedReason;

  final List<String> reasons = [
    "✨ just not my pace",
    "🌸 just not for me",
    "🌱 Wishing them good vibes ahead",
    "🧘 Taking a break from dating",
    "🚨 Had a concern"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unmatch", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Could you share why you’re choosing to unmatch?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: reasons.map((reason) {
                return ChoiceChip(
                  label: Text(reason),
                  selected: selectedReason == reason,
                  onSelected: (selected) {
                    setState(() {
                      selectedReason = reason;
                    });
                  },
                  selectedColor: Colors.purple.shade100,
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: selectedReason == null ? null : () {},
              child: Text("Submit and Unmatch", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
