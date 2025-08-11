import 'package:flutter/material.dart';
import '../../subcategoryScreen.dart';

class SelectPromptCategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': '💬', 'label': 'Conversations I Crave'},
    {'icon': '🫀', 'label': 'Deep Cuts'},
    {'icon': '🧘‍♂️', 'label': 'Inner Beliefs'},
    {'icon': '🌱', 'label': 'Self Discovery'},
  ];

  // Full data for each category
  final Map<String, Map<String, dynamic>> categoryData = {
    'Conversations I Crave': {
      'icon': Icons.chat,
      'prompts': [
        'A voice note I’d love to receive would say…',
        'Let’s debate this (playfully):',
        'When a convo flows, I feel…',
        'A topic I could talk about for hours:',
      ],
    },
    'Deep Cuts': {
      'icon': Icons.favorite,
      'prompts': [
        'Something I’m still figuring out is…',
        'Something I’m learning to unlearn:',
      ],
    },
    'Inner Beliefs': {
      'icon': Icons.self_improvement,
      'prompts': [
        'A belief I hold strongly is…',
        'What grounds me when I feel lost is…',
        'An inner narrative I’m shifting is…',
      ],
    },
    'Self Discovery': {
      'icon': Icons.nature,
      'prompts': [
        'What I’ve outgrown lately:',
        'People often describe me as…',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select the category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ...categories.map((cat) {
              final label = cat['label'];
              final iconEmoji = cat['icon'];
              final data = categoryData[label]!;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubcategoryScreen(
                        title: label,
                        icon: data['icon'],
                        prompts: List<String>.from(data['prompts']),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(iconEmoji, style: TextStyle(fontSize: 20)),
                      SizedBox(width: 12),
                      Text(
                        label,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
