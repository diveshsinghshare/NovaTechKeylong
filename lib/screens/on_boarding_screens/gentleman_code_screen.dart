import 'package:flutter/material.dart';

import 'interested_screen.dart';

class GentlemanCodeScreen extends StatefulWidget {
  const GentlemanCodeScreen({Key? key}) : super(key: key);

  @override
  State<GentlemanCodeScreen> createState() => _GentlemanCodeScreenState();
}

class _GentlemanCodeScreenState extends State<GentlemanCodeScreen> {
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              "The Gentleman's Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            /// Image at the top
            Image.asset(
              "assets/man_code.jpg", // replace with your image path
              height: 100,
            ),
            const SizedBox(height: 20),

            /// Description text
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "By entering Nova, you agree to uphold our community standard:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Pledge points
            pledgePoint("🧠", "I will initiate conversations with thoughtfulness and respect."),
            pledgePoint("🤝", "I will accept the decisions of others gracefully, even if there's no spark."),
            pledgePoint("🌱", "I will contribute to a community where everyone feels valued."),
            const SizedBox(height: 20),

            /// Checkbox
            Row(
              children: [
                Checkbox(
                  value: isAccepted,
                  activeColor: const Color(0xFF6A4375),
                  onChanged: (val) {
                    setState(() {
                      isAccepted = val ?? false;
                    });
                  },
                ),
                const Text(
                  "I Accept the Code",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const Spacer(),

            /// Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A4375),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isAccepted ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => InterestedInScreen()));

                } : null,
                child: const Text(
                  "continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Widget for pledge points
  Widget pledgePoint(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
