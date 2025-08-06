import 'package:flutter/material.dart';
import 'selectPromptCategoryScreen.dart';

class SelectPromptScreen extends StatelessWidget {
  final int selectedCount;

  const SelectPromptScreen({super.key, this.selectedCount = 0});

  @override
  Widget build(BuildContext context) {
    bool isContinueEnabled = selectedCount >= 2;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 24),

            // Header text
            Text(
              "Share a few things about you",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),

            // Prompt selection list
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SelectPromptCategoryScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Select a prompt",
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          Icon(Icons.add_circle, color: Colors.deepPurple),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Instructional footer text
            Center(
              child: Text(
                "Pick at least 2 prompts that feel most like you",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),

            // Continue button
            ElevatedButton(
              onPressed: isContinueEnabled
                  ? () {
                // TODO: Replace with your next screen or flow
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectPromptCategoryScreen()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isContinueEnabled ? Colors.deepPurple : Colors.grey[300],
                minimumSize: Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isContinueEnabled ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
