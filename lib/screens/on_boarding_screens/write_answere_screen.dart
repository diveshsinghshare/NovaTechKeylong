import 'package:flutter/material.dart';
import 'package:novatech/models/profile_singlaton.dart';

class WriteAnswerScreen extends StatefulWidget {
  final int index;
  final String question;
  final String answer;

  const WriteAnswerScreen({
    super.key,
    required this.question,
    required this.answer,
    required this.index,
  });

  @override
  State<WriteAnswerScreen> createState() => _WriteAnswerScreenState();
}

class _WriteAnswerScreenState extends State<WriteAnswerScreen> {
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.question);
    _answerController = TextEditingController(text: widget.answer);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveAnswer() {
    final promptQ = PromptQuestion(
      question: _questionController.text,
      answer: _answerController.text,
      index: widget.index,
    );

    ProfileSingleton.instance.promptList[widget.index] = promptQ;

    Navigator.pop(context); // Go back to previous screen
    Navigator.pop(context); // Go back to previous screen
    Navigator.pop(context); // Go back to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write answers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: "Question",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Note: Feel free to improve the prompt",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _answerController,
              maxLength: 200,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Write your answer...",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _saveAnswer,
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
