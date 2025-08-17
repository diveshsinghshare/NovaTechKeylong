import 'package:flutter/material.dart';

import 'interested_screen.dart';

class FemalePledgeScreen extends StatefulWidget {
  const FemalePledgeScreen({Key? key}) : super(key: key);

  @override
  State<FemalePledgeScreen> createState() => _FemalePledgeScreenState();
}

class _FemalePledgeScreenState extends State<FemalePledgeScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Title
              const Text(
                "The Radiance Code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Female Pledge Image
              Image.asset(
                "assets/female_code.jpg", // <-- your female pledge image
                height: 120,
              ),

              const SizedBox(height: 20),

              // Description
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "By entering Nova, you agree to help our community flourish:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Bullet Points
              const Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("❤️ I will engage thoughtfully with genuine effort.",
                        style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text("✨ I will provide clear and respectful closure when I'm not interested.",
                        style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text("🤝 I will help maintain a kind and responsive environment.",
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              const Spacer(),

              // Checkbox
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text("I Accept the Code"),
                ],
              ),

              const SizedBox(height: 10),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A4375),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isChecked ? () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => InterestedInScreen()));

                  } : null,
                  child: const Text(
                    "continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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
