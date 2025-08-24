import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _showConfirmationDialog(
      BuildContext context, String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Phone number",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              "9999999999",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "(Note: you can't change the phone number)",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const Divider(height: 32),

            const Text(
              "Legal",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            ListTile(
              title: const Text("FAQ"),
              onTap: () => _openLink("https://yourapp.com/faq"),
            ),
            ListTile(
              title: const Text("Privacy policy"),
              onTap: () => _openLink("https://yourapp.com/privacy"),
            ),
            ListTile(
              title: const Text("Terms of service"),
              onTap: () => _openLink("https://yourapp.com/terms"),
            ),
            ListTile(
              title: const Text("Contact us"),
              onTap: () => _openLink("https://yourapp.com/contact"),
            ),
            const Spacer(),

            // Logout Button
            Center(
              child: SizedBox(
                width: 180,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Log out"),
                  onPressed: () {
                    _showConfirmationDialog(
                      context,
                      "Log out",
                      "Are you sure you want to log out?",
                          () {
                        // TODO: Handle logout logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logged out successfully")),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Delete Account Button
            Center(
              child: GestureDetector(
                onTap: () {
                  _showConfirmationDialog(
                    context,
                    "Delete Account",
                    "Are you sure you want to delete your account? This action cannot be undone.",
                        () {
                      // TODO: Handle delete account logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Account deleted")),
                      );
                    },
                  );
                },
                child: const Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
