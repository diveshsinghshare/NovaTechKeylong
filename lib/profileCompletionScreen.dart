import 'package:flutter/material.dart';
import 'bio_screen.dart';
import 'models/profile_singlaton.dart';
class ProfileCompletionScreen extends StatelessWidget {
  const ProfileCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEEFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 4),
                      Text("Get Started",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 4),
                      Text("Show Your Vibe",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.radio_button_unchecked, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("Complete Your Profile",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: CircularProgressIndicator(
                        value: 0.6,
                        strokeWidth: 8,
                        backgroundColor: Colors.pink.withOpacity(ProfileSingleton.instance.profileProgress / 100),
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                      ),
                    ),
                    Text("${ProfileSingleton.instance.profileProgress}%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  "Almost there! Complete your profile to unlock the full experience",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  "Photos, prompts, let them see you shine.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BioScreen()),
                );
                // TODO: Navigate to final step
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "keep the vibe going",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
