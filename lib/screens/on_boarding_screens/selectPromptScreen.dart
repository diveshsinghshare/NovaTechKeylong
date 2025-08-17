import 'package:flutter/material.dart';
import 'package:novatech/models/profile_singlaton.dart';
import 'package:novatech/screens/on_boarding_screens/selectPromptCategoryScreen.dart';
import 'package:novatech/screens/on_boarding_screens/voice_prompt_screen.dart';
import 'package:novatech/screens/on_boarding_screens/write_answere_screen.dart';
import 'package:novatech/main.dart'; // Import the global routeObserver

void main() {
  runApp(const MaterialApp(home: SelectPromptScreen()));
}

class SelectPromptScreen extends StatefulWidget {
  const SelectPromptScreen({super.key});

  @override
  State<SelectPromptScreen> createState() => _SelectPromptScreenState();
}

class _SelectPromptScreenState extends State<SelectPromptScreen> with RouteAware {
  // Example prompts list
   List<PromptQuestion> prompts = [
    PromptQuestion(question: '', answer: '',index:0),
    PromptQuestion(question: '', answer: '',index:1),
    PromptQuestion(question: '', answer: '',index:2),
  ];

   int get selectedCount => prompts
       .where((p) => p.question.isNotEmpty && p.answer.isNotEmpty)
       .length;

   void _loadData() {

     prompts = List.from(ProfileSingleton.instance.promptList);

     setState(() {
       // Reload your data here
       debugPrint("Reloaded at ${DateTime.now()}");
     });
   }

  // Called when coming back from another screen
  @override
  void didPopNext() {
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }


@override
  Widget build(BuildContext context) {
    final bool isContinueEnabled = selectedCount >= 2;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: 0.2,
                backgroundColor: Colors.grey[300],
                valueColor:
                const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                minHeight: 4,
              ),
              const SizedBox(height: 24),

              const Text(
                "Share a few things about you",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView.builder(
                  itemCount: prompts.length,
                  itemBuilder: (_, index) {
                    final prompt = prompts[index];
                    final hasAnswer = prompt.question.isNotEmpty &&
                        prompt.answer.isNotEmpty;

                    return GestureDetector(
                      onTap: () async {
                        print("prompt.index");
                        print(prompt.index);
                        if (hasAnswer) {
                          // Already has data → open answer editor
                          final result =
                          await Navigator.push<Map<String, String>?>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WriteAnswerScreen(
                                question: prompt.question,
                                answer: prompt.answer,index: prompt.index,isPromtEditMode:true
                              ),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              prompt.question =
                                  result['question'] ?? prompt.question;
                              prompt.answer =
                                  result['answer'] ?? prompt.answer;
                            });
                          }
                        } else {
                          // No data → select category first
                          final selectedQuestion =
                          await Navigator.push<String?>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                               SelectPromptCategoryScreen(index:prompt.index),
                            ),
                          );

                          if (selectedQuestion == null) return;

                          final result =
                          await Navigator.push<Map<String, String>?>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WriteAnswerScreen(
                               question: '', answer: '',index: index,isPromtEditMode:false
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              prompt.question =
                                  result['question'] ?? selectedQuestion;
                              prompt.answer = result['answer'] ?? '';
                            });
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: hasAnswer
                                ? Colors.deepPurple
                                : Colors.grey.shade400,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: hasAnswer
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    prompt.question,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.edit,
                                    color: Colors.deepPurple),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              prompt.answer,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Select a prompt",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ),
                            const Icon(Icons.add_circle,
                                color: Colors.deepPurple),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Pick at least 2 prompts that feel most like you",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isContinueEnabled
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VoicePromptScreen(),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isContinueEnabled
                        ? Colors.deepPurple
                        : Colors.grey[300],
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isContinueEnabled
                          ? Colors.white
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
