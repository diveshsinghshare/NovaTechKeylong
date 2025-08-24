import 'package:flutter/material.dart';
import '../../models/profile_singlaton.dart';
import 'religious_belief_screen.dart';
import 'language_selection_screen.dart'; // <- Import the language selection screen

class SelectHeightScreen extends StatefulWidget {
  @override
  _SelectHeightScreenState createState() => _SelectHeightScreenState();
}

class _SelectHeightScreenState extends State<SelectHeightScreen> {
  String? selectedHeight;
  List<String> selectedLanguages = [];

  final List<String> heightOptions = [
    '4\'0"', '4\'1"', '4\'2"', '4\'3"', '4\'4"', '4\'5"', '4\'6"',
    '5\'0"', '5\'1"', '5\'2"', '5\'3"', '5\'4"', '5\'5"', '5\'6"',
    '6\'0"', '6\'1"', '6\'2"', '6\'3"', '6\'4"', '6\'5"', '6\'6"',
  ];

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
              value: 0.1,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
            SizedBox(height: 20),

            // Height Section
            Text(
              "How tall are you?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Note: Feel free to take it back anytime, your space, your pace",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'select your height',
              ),
              value: selectedHeight,
              items: heightOptions.map((height) {
                return DropdownMenuItem<String>(
                  value: height,
                  child: Text(height),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedHeight = value;
                });
              },
            ),

            SizedBox(height: 30),

            // Language Section
            Text(
              "How many languages can you speak?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Start with your mother tongue, comfort speaks volumes",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),

            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelectionScreen(
                      preselected: selectedLanguages,
                    ),
                  ),
                );

                if (result != null && result is List<String>) {
                  setState(() {
                    selectedLanguages = result;
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search your languages",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12),

            // Chips for selected languages
            Wrap(
              spacing: 8,
              children: selectedLanguages.map((lang) {
                return Chip(
                  label: Text(lang),
                  backgroundColor: Colors.purple.shade100,
                  deleteIcon: Icon(Icons.close, size: 18),
                  onDeleted: () {
                    setState(() {
                      selectedLanguages.remove(lang);
                    });
                  },
                );
              }).toList(),
            ),

            Spacer(),

            // Continue Button
            ElevatedButton(
              onPressed: (selectedHeight != null && selectedLanguages.isNotEmpty)
                  ? () {
                ProfileSingleton.instance.height = selectedHeight ?? "";
                ProfileSingleton.instance.selectedLanguages = selectedLanguages;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReligiousBeliefScreen()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
