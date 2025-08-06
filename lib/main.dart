import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:novatech/phonenumber_screen.dart';

void main() {
  runApp(NovaApp());
}

class NovaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nova',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isChecked = false;

  final List<String> imagePaths = [
    'assets/page1.jpg',
    'assets/page2.jpg',
    'assets/page3.jpg',
    //'assets/page3.jpg',
  ];

  final List<String> headings = [
    'Feel first, Photos come later',
    'No Ghosting, Just Grace',
    'You deserve to feel safe',
    //'Real , Respectful',
  ];

  final List<String> subtexts = [
    'We blur profile photos initially to help you connect beyond appearances',
    'We know it’s easier to vanish, but it’s kinder to close the loop. That’s why Nova offers gentle closure notes to help you say goodbye.',
    'Nova protects your emotional space, with AI that quietly detects toxicity, scams, and red flags.',
    //'I certify that: I am at least 18 years old; and I have read and expressly consent to the Nova Privacy Policy, Terms and Conditions, and personal information I choose to share to improve my experience.',
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to next screen
    }
  }

  Widget _buildBottomButton() {
    if (_currentPage == 2) {
      // Third screen (Create/Sign in)
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhoneNumberScreen(isSignUp: true),
                ),
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5D3A7C),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Create account',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhoneNumberScreen(isSignUp: false),
                ),
              );

            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF5D3A7C),
              side: const BorderSide(color: Color(0xFF5D3A7C)),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Sign in'),
          ),
        ],
      );
    } else if (_currentPage == 3) {
      // Fourth screen with checkbox
      return Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (val) {
                  setState(() {
                    _isChecked = val!;
                  });
                },
              ),
              Expanded(
                child: Text(
                  subtexts[_currentPage],
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _isChecked ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5D3A7C),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('continue'),
          ),
        ],
      );
    } else {
      // Default "Continue"
      return ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5D3A7C),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'continue',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 10),
                child: Text('Skip', style: TextStyle(color: Colors.grey[700])),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5D3A7C),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(imagePaths[index], height: 360),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        headings[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      if (index != 3)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            subtexts[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imagePaths.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 10 : 8,
                  height: _currentPage == index ? 10 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.deepPurple
                        : Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            // Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildBottomButton(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
