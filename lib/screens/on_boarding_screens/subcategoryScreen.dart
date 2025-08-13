import 'package:flutter/material.dart';
import 'package:novatech/screens/on_boarding_screens/write_answere_screen.dart';

class SubcategoryScreen extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final List<String> prompts;

  const SubcategoryScreen({
    Key? key,
    required this.index,
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
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WriteAnswerScreen(
                        question: prompts[index], answer: "",index: index,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    prompts[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
