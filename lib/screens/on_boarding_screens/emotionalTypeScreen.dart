import 'package:flutter/material.dart';
import '../../models/profile_singlaton.dart';
import 'interestSelectionScreen.dart';
class EmotionalTypeScreen extends StatefulWidget {
  @override
  _EmotionalTypeScreenState createState() => _EmotionalTypeScreenState();
}

class _EmotionalTypeScreenState extends State<EmotionalTypeScreen> {
  final List<String> selectedTypes = [];

  final List<Map<String, String>> emotionalTypes = [
    {'icon': '🧘', 'title': 'Calm', 'subtitle': 'Soft, peaceful, chill energy'},
    {'icon': '😄', 'title': 'Fun', 'subtitle': 'Likes to laugh, play, enjoy'},
    {'icon': '🗣️', 'title': 'Talkative', 'subtitle': 'Loves long chats and quick replies'},
    {'icon': '🤫', 'title': 'Quiet', 'subtitle': 'Keeps it lowkey, opens up slowly'},
    {'icon': '🌹', 'title': 'Romantic', 'subtitle': 'Loves love, sweet gestures, feelings'},
    {'icon': '🎯', 'title': 'Focused', 'subtitle': 'Serious about life, career, goals'},
    {'icon': '😉', 'title': 'Flirty', 'subtitle': 'Light teasing, playful energy'},
    {'icon': '🌊', 'title': 'Deep', 'subtitle': 'Asks real questions, doesn’t like small talk'},
  ];

  void onTypeTap(String type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
      } else {
        if (selectedTypes.length < 3) {
          selectedTypes.add(type);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: 0.33,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 16),
            Text(
              'Emotional type',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('Pick 3 that reflect you; how you feel, express, and connect'),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: emotionalTypes.length,
                itemBuilder: (context, index) {
                  final item = emotionalTypes[index];
                  final isSelected = selectedTypes.contains(item['title']);
                  return GestureDetector(
                    onTap: () => onTypeTap(item['title']!),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected ? Colors.deepPurple : Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected ? Colors.deepPurple.withOpacity(0.05) : Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(item['icon']!, style: TextStyle(fontSize: 20)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['title']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(item['subtitle']!,
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          Spacer(),
                          if (isSelected)
                            Icon(Icons.check_box_rounded, color: Colors.deepPurple)
                          else
                            Icon(Icons.check_box_outline_blank, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // TODO: Add navigation

                ProfileSingleton.instance.emotionalType = selectedTypes;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InterestSelectionScreen()),
                );
              },
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
