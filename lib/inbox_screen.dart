import 'package:flutter/material.dart';

class InboxTab extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      "name": "Arjun",
      "message": "Start the conversation",
      "image":
      "https://via.placeholder.com/150/0000FF/FFFFFF/?text=Arjun" // Replace with actual image URL or asset
    },
  ];

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
              Text(
                "Inbox",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(height: 24, thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(msg["image"]!),
                        radius: 24,
                      ),
                      title: Text(
                        msg["name"]!,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        msg["message"]!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      onTap: () {
                        // Handle chat navigation
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
