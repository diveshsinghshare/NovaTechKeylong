import 'package:flutter/material.dart';

class SubcategoryScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> prompts;

  const SubcategoryScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.prompts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Row(
          children: [
            Icon(icon, color: Colors.red), // Customize icon color per category
            SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: prompts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              readOnly: true,
              initialValue: prompts[index],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
