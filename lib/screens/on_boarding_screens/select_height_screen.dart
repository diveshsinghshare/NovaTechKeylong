import 'package:flutter/material.dart';
import '../../models/profile_singlaton.dart';
import '../../welcome.dart';
import 'religious_belief_screen.dart';
class SelectHeightScreen extends StatefulWidget {
  @override
  _SelectHeightScreenState createState() => _SelectHeightScreenState();
}

class _SelectHeightScreenState extends State<SelectHeightScreen> {
  String? selectedHeight;
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
            Spacer(),
            ElevatedButton(
              onPressed: selectedHeight != null ? () {
                // Navigate to next screen
                ProfileSingleton.instance.height = selectedHeight ?? "";

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReligiousBeliefScreen()),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
                // );
              } : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
              ).copyWith(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => selectedHeight != null ? Colors.purple : Colors.grey.shade300,
                ),
              ),
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
