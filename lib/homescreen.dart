import 'package:flutter/material.dart';
import 'likes_screen.dart';
import 'inbox_screen.dart';
import 'profile_screen.dart';
import 'full_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create a PageController for transitions
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Animate the page view to the selected index
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EEF8),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomeTab(),
          LikesTab(),
          InboxTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF6D4376),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Likes'),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Arjun',
      'age': 27,
      'mbti': 'ESFP',
      'bio': 'Chasing sunsets and deep conversations, bonus points if you love road trips.',
      'tags': ['Concerts & festivals', 'Camping', 'Meditation', 'Foodie', 'Painting', 'Tennis'],
      'image': 'https://i.imgur.com/1k3WvAO.jpeg', // Replace with your asset or network image
    },
    {
      'name': 'Jay',
      'age': 26,
      'mbti': 'INTJ',
      'bio': 'I am a free spirited person, who wants to travel the world, looking for a partner along the way.',
      'tags': ['Movie nights', 'Hiking', 'Coffee lover', 'Anime', 'Cycling'],
      'image': 'https://i.imgur.com/1k3WvAO.jpeg', // Replace with your asset or network image
    },
    {
      'name': 'Aniketh',
      'age': 25,
      'mbti': 'ISFJ',
      'bio': 'Let’s write a story worth telling, preferably with snacks.',
      'tags': ['Stand-up comedy', 'Road trips', 'Yoga', 'Baking', 'Gaming', 'Basketball'],
      'image': 'https://i.imgur.com/1k3WvAO.jpeg', // Replace with your asset or network image
    },
    {
      'name': 'Kripa',
      'age': 28,
      'mbti': 'ISTP',
      'bio': 'Big on empathy, low on drama, here for something real!',
      'tags': ['Singing / Karaoke', 'Beach days', 'Running', 'Cooking', 'Board games', 'Basketball'],
      'image': 'https://i.imgur.com/qRZVJYA.png',
    },
    {
      'name': 'Dev',
      'age': 32,
      'mbti': 'INTP',
      'bio': 'Curious mind, kind heart, always up for deep talks and spontaneous plans',
      'tags': ['Podcasts', 'Scuba diving', 'Yoga', 'Coffee lover', 'Reading', 'Basketball'],
      'image': 'https://i.imgur.com/qRZVJYA.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF6D4376),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Before You Dive In:\nThis is only a sample preview, not the real thing.\nComplete your profile, the good stuff will come after.',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          SizedBox(height: 16),
          ...profiles.map((profile) {
            return GestureDetector(
              onTap: () {
                // 👇 Add your navigation or action here
                // Handle next step
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileViewScreen()),
                );


              },
              child: _buildProfileCard(profile),
            );
          }).toList(),        ],
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.network(
              profile['image'],
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFFF2DDF3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile['name']}, ${profile['age']} 🜲',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  profile['bio'],
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  'MBTI: ${profile['mbti']}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile['tags'].map<Widget>((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Color(0xFFD6C1DA),
                      labelStyle: TextStyle(fontSize: 12),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

