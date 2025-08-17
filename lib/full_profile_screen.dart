import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/profile_singlaton.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildScores(),
              const SizedBox(height: 16),
              _buildInfoSection(),
              const SizedBox(height: 16),
              _buildBio(),
              const SizedBox(height: 16),
              _buildVoicePrompt(),
              const SizedBox(height: 16),
              _buildPrompts(),
              const SizedBox(height: 16),
              _buildVideoNote(),
              const SizedBox(height: 16),
              _buildPhotos(),
              const SizedBox(height: 16),
              _buildLifestyle(),
              const SizedBox(height: 16),
              _buildInterests(),
              const SizedBox(height: 16),
              _buildEmotionalType(),
              const SizedBox(height: 16),
              _buildSpotifySection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/dummy.jpg'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("${ProfileSingleton.instance.name}, ${ProfileSingleton.instance.dob}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(ProfileSingleton.instance.bio),
              Text(ProfileSingleton.instance.location),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScores() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const [
        _ScoreCard(title: 'Vibe Score', score: '70%'),
        _ScoreCard(title: 'Kind Score', score: '92%'),
        _ScoreCard(title: 'Activeness', score: '84%'),
        _ScoreCard(title: 'Ready for love'),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        InfoTag(text: ProfileSingleton.instance.gender),
         InfoTag(text: ProfileSingleton.instance.sexualOrientation.toString()),
         InfoTag(text: ProfileSingleton.instance.height),
         InfoTag(text: ProfileSingleton.instance.mbti),
         InfoTag(text: ProfileSingleton.instance.religiousBeliefs.toString()),
         InfoTag(text: ProfileSingleton.instance.linkedProfile),
      ],
    );
  }

  Widget _buildBio() {
    return  Text(
      'Bio\n $ProfileSingleton.instance.gender',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildVoicePrompt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Voice Prompts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: const [
              Icon(Icons.play_circle_fill, size: 40),
              SizedBox(width: 12),
              Expanded(child: Text('The book/show that changed how I think')),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPrompts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Prompts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 8),
        Text('The first thing people notice about me is'),
        Text("Probably my loud laugh, I'm not great at whispering joy. But hey, it's contagious!"),
      ],
    );
  }

  Widget _buildVideoNote() {
    final Uri youtubeUrl = Uri.parse('https://www.youtube.com/watch?v=HHBF5efMTPI');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Video notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            if (await canLaunchUrl(youtubeUrl)) {
              await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication);
            } else {
              // Handle error
              print('Could not launch $youtubeUrl');
            }
          },
          child: const AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black26),
              child: Center(child: Icon(Icons.play_circle_outline, size: 40)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotos() {
    // Example photo URLs (replace with your own or use assets if needed)
    final photoUrls = [
      'https://ibb.co/KczY9WYh',
      'https://ibb.co/KczY9WYh',
      'https://via.placeholder.com/100x140.png?text=3',
      'https://via.placeholder.com/100x140.png?text=4',
      'https://via.placeholder.com/100x140.png?text=5',
      'https://via.placeholder.com/100x140.png?text=6',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(photoUrls.length, (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                photoUrls[index],
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 100,
                    height: 140,
                    color: Colors.grey[300],
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 140,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLifestyle() {
    return _buildTagSection('Lifestyle', [
      'Night owl',
      'I enjoy drinking',
      'Non-smoker',
      'I have a pet',
      'Exercise daily',
    ]);
  }

  Widget _buildInterests() {
    return _buildTagSection('Interests', [
      'Movie nights',
      'Beach days',
      'Journaling',
      'Cooking',
      'Anime',
      'Cycling',
    ]);
  }

  Widget _buildEmotionalType() {
    return _buildTagSection('Emotional type', [
      'fun', 'talkative', 'Focused'
    ]);
  }

  Widget _buildSpotifySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Spotify', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 8),
        Text('My top 3 artists'),
        SizedBox(height: 4),
        Text('• Artist One'),
        Text('• Artist Two'),
        Text('• Artist Three'),
      ],
    );
  }

  Widget _buildTagSection(String title, List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) => Chip(label: Text(tag))).toList(),
        )
      ],
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final String? score;

  const _ScoreCard({required this.title, this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.purple[50],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (score != null) Text(score!),
        ],
      ),
    );
  }
}

class InfoTag extends StatelessWidget {
  final String text;

  const InfoTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey[200],
    );
  }
}