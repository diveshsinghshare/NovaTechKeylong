import 'package:flutter/material.dart';
import 'profileCompletionScreen.dart';
class LifestyleHabitsScreen extends StatefulWidget {
  @override
  _LifestyleHabitsScreenState createState() => _LifestyleHabitsScreenState();
}

class _LifestyleHabitsScreenState extends State<LifestyleHabitsScreen> {
  Map<String, String> selectedOptions = {};

  final Map<String, List<String>> questions = {
    'Are you an 🌞 early bird or 🌙 a night owl?': ['Early bird', 'Night owl'],
    'Do you drink alcohol?': ['I enjoy drinking', 'I don’t drink', 'Occasionally, I drink'],
    'Do you smoke?': ['Smoker', 'Non-smoker', 'Occasionally, I smoke'],
    'Do you have pets?': [
      'I have a pet',
      'interested to have pets',
      'Not interested in pets'
    ],
    'Do you exercise?': [
      'Exercises Daily',
      'Exercises few times a week',
      'Exercises Rarely',
      'Never exercised'
    ],
  };

  void selectAnswer(String question, String answer) {
    setState(() {
      selectedOptions[question] = answer;
    });
  }

  Widget buildOption(String question, String option) {
    final isSelected = selectedOptions[question] == option;
    return GestureDetector(
      onTap: () => selectAnswer(question, option),
      child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple[50] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.deepPurple : Colors.black87,
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
              value: 0.75,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 16),
            Text(
              "Let’s uncover your lifestyle, habits and all fun stuff",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: questions.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        children: entry.value
                            .map((option) => buildOption(entry.key, option))
                            .toList(),
                      ),
                      SizedBox(height: 20),
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileCompletionScreen()));

              },
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
