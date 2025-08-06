import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final double profileCompletion = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://ui-avatars.com/api/?size=128"), // Replace with actual image
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Divesh, 41 ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Icon(Icons.verified, color: Colors.green, size: 18),
                            SizedBox(width: 4),
                            Icon(Icons.phone_android,
                                color: Colors.green, size: 18),
                            SizedBox(width: 4),
                            Icon(Icons.email, color: Colors.green, size: 18),
                          ],
                        ),
                        Text(
                          "Hyderabad, Telangana",
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
              SizedBox(height: 24),
              // Progress Section
              Text("Complete your profile",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Row(
                children: [
                  Text("Profile completeness 80%"),
                  SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: profileCompletion,
                      color: Colors.deepPurple,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Action Tiles
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildTile("Add your job", Icons.work),
                    _buildTile("Add Voice Prompts", Icons.mic),
                    _buildTile("Add Video Notes", Icons.videocam),
                    _buildTile("Add your MBTI", Icons.psychology),
                    _buildTile("Connect Spotify", Icons.music_note),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.deepPurple),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
