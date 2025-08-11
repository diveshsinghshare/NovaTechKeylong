import 'package:flutter/material.dart';
import 'models/profile_singlaton.dart';
import 'screens/on_boarding_screens/ghibliPhotoScreen.dart';
class BioScreen extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: LinearProgressIndicator(
                value: 0.25, // Assuming 25% of a multi-step form
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6D4376)), // Dark Purple
              ),
            ),

            // Bio Text & Subtext
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your bio is your vibe",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Just one honest line helps others see the real you",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Bio input
                  TextField(
                    controller: bioController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "write here...",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue tap
                    String bioText = bioController.text;
                    print("User Bio: $bioText");
                    ProfileSingleton.instance.bio = bioText;

                    Navigator.push(context, MaterialPageRoute(builder: (_) => GhibliPhotoScreen()));


                    // Navigate or validate...
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6D4376), // Dark Purple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
