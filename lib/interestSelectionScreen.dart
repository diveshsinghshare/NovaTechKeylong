import 'package:flutter/material.dart';
import 'lifestyleHabitsScreen.dart';
class InterestSelectionScreen extends StatefulWidget {
  @override
  _InterestSelectionScreenState createState() => _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  Set<String> selectedInterests = {};

  final Map<String, List<String>> interestCategories = {
    'Music & Entertainment': [
      '🎶 Live music',
      '🎤 Singing / Karaoke',
      '🎛️ DJing',
      '🎧 Podcasts',
      '🎬 Movie nights',
      '🎭 Theatre / Acting',
      '🎙️ Stand-up comedy',
      '🎟️ Concerts & festivals',
      '📺 Binge-watching series',
    ],
    'Outdoors & Travel': [
      '🥾 Hiking',
      '🏕️ Camping',
      '🚗 Road trips',
      '🎒 Backpacking',
      '🏖️ Beach days',
      '🌲 National parks',
      '🤿 Scuba diving',
      '📸 Travel photography',
    ],
    'Wellness & Lifestyle': [
      '🧘 Yoga',
      '🧘‍♂️ Meditation',
      '🏋️ Gym workouts',
      '🏃 Running',
      '💬 Self-care routines',
      '🧠 Mindfulness',
      '📓 Journaling',
      '🥗 Eating healthy',
    ],
  };

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  Widget buildInterestButton(String label) {
    final isSelected = selectedInterests.contains(label);
    return GestureDetector(
      onTap: () => toggleInterest(label),
      child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple[50] : Colors.white,
          border: Border.all(
              color: isSelected ? Colors.deepPurple : Colors.grey.shade400),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.deepPurple : Colors.black,
          ),
        ),
      ),
    );
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
              value: 0.5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 16),
            Text(
              "Your interests say a lot, let's hear them",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: interestCategories.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        children: entry.value
                            .map((interest) => buildInterestButton(interest))
                            .toList(),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                }).toList(),
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
                // TODO: Navigate to next screen

                Navigator.push(context, MaterialPageRoute(builder: (_) => LifestyleHabitsScreen()));

              },
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
