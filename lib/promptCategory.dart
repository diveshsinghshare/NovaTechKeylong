import 'package:flutter/cupertino.dart';

class PromptCategory {
  final String title;
  final IconData icon;
  final List<String> prompts;

  PromptCategory({
    required this.title,
    required this.icon,
    required this.prompts,
  });
}
