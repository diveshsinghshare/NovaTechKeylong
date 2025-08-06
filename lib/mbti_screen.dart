import 'package:flutter/material.dart';
import 'emotionalTypeScreen.dart';
class MBTIScreen extends StatefulWidget {
  @override
  _MBTIScreenState createState() => _MBTIScreenState();
}

class _MBTIScreenState extends State<MBTIScreen> {
  List<String> mbtiTypes = [
    "INTJ", "INTP", "ENTJ", "ENTP",
    "INFJ", "INFP", "ENFJ", "ENFP",
    "ISTJ", "ISFJ", "ESTJ", "ESFJ",
    "ISTP", "ISFP", "ESTP", "ESFP"
  ];

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        title: LinearProgressIndicator(
          value: 0.3,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B457A)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Skip logic
              Navigator.pop(context);
            },
            child: Text("Skip", style: TextStyle(color: Colors.grey)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("What’s your  MBTI?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(
              "These are personality types based on how you think and feel, helps us match your vibe.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mbtiTypes.length,
                itemBuilder: (context, index) {
                  String type = mbtiTypes[index];
                  return RadioListTile(
                    title: Text(type),
                    activeColor: Color(0xFF6B457A),
                    value: type,
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6B457A),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmotionalTypeScreen()),
                  );                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
