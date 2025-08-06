import 'package:flutter/material.dart';

class LikesTab extends StatelessWidget {
  final List<Map<String, String>> admirers = [
    {
      "name": "Arjun",
      "age": "27",
      "image":
      "https://via.placeholder.com/150/0000FF/FFFFFF/?text=Arjun" // Replace with actual image URL or asset
    },
    {
      "name": "Raj",
      "age": "28",
      "image":
      "https://via.placeholder.com/150/FF5733/FFFFFF/?text=Raj" // Replace with actual image URL or asset
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hearts received",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Your presence is magnetic, ${admirers.length} new admirers today!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: admirers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final admirer = admirers[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/dummy.jpg'), // ✅ Correct usage
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Text(
                              "${admirer["name"]}, ${admirer["age"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
