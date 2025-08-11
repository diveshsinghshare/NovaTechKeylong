import 'package:flutter/material.dart';
import '../../models/profile_singlaton.dart';
import 'select_height_screen.dart';
class OrientationScreen extends StatefulWidget {
  @override
  _OrientationScreenState createState() => _OrientationScreenState();
}

class _OrientationScreenState extends State<OrientationScreen> {
  final List<String> options = [
    "Straight", "Gay", "Lesbian", "Bisexual", "Demisexual",
    "Asexual", "Queer", "Pansexual", "Questioning"
  ];

  final Set<String> selectedOptions = {};
  bool showOnProfile = false;

  void toggleOption(String value) {
    setState(() {
      if (selectedOptions.contains(value)) {
        selectedOptions.remove(value);
      } else if (selectedOptions.length < 3) {
        selectedOptions.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
            SizedBox(height: 20),
            Text(
              "What’s your sexual orientation?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("you can select upto 3"),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: options.map((option) {
                final selected = selectedOptions.contains(option);
                return ChoiceChip(
                  label: Text(option),
                  selected: selected,
                  onSelected: (_) => toggleOption(option),
                  selectedColor: Colors.purple,
                  labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: showOnProfile,
                  onChanged: (value) {
                    setState(() {
                      showOnProfile = value ?? false;
                      ProfileSingleton.instance.showOrientationOnProfile = showOnProfile;
                    });
                  },
                  activeColor: Colors.purple,
                ),
                Text("Show my sexual orientation on my profile"),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle next step
                ProfileSingleton.instance.sexualOrientation = selectedOptions;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectHeightScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.purple,
              ),
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
