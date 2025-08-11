import 'package:flutter/material.dart';
import '../../models/profile_singlaton.dart';
import 'mbti_screen.dart'; // Import the next screen

class ReligiousBeliefScreen extends StatefulWidget {
  @override
  _ReligiousBeliefScreenState createState() => _ReligiousBeliefScreenState();
}

class _ReligiousBeliefScreenState extends State<ReligiousBeliefScreen> {
  List<String> beliefs = [
    'Hinduism',
    'Christianity',
    'Islam',
    'Sikhism',
    'Buddhism',
    'Jainism',
    'none'
  ];

  Set<String> selected = {};
  bool showReligion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: LinearProgressIndicator(
          value: 0.2,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B457A)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("What’s your religious beliefs?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: beliefs.map((belief) {
                return FilterChip(
                  label: Text(belief),
                  selected: selected.contains(belief),
                  selectedColor: Color(0xFF6B457A).withOpacity(0.1),
                  onSelected: (bool value) {
                    setState(() {
                      if (value)
                        selected.add(belief);
                      else
                        selected.remove(belief);
                    });
                  },
                  backgroundColor: Colors.grey[100],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected.contains(belief)
                        ? Color(0xFF6B457A)
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: showReligion,
                  onChanged: (val) {
                    setState(() {
                      showReligion = val!;
                    });
                  },
                  activeColor: Color(0xFF6B457A),
                ),
                Text("Show my religion on my profile")
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6B457A),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),

                onPressed: () {
                  ProfileSingleton.instance.religiousBeliefs = selected;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MBTIScreen()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
