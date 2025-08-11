// profile_model.dart
class Profile {
  final String name;
  final String dob;
  final String gender;
  final List<String> sexualOrientation;
  final bool showOrientationOnProfile;
  final String location;
  final String intentions;
  final String mbti;
  final String bio;
  final String height;
  final int profileProgress;
  final List<String> interestedIn;
  final List<String> novaIntentions;
  final int id;
  final bool isVerifiedPhoto;
  final bool isVerifiedVideo;

  Profile({
    required this.name,
    required this.dob,
    required this.gender,
    required this.sexualOrientation,
    required this.showOrientationOnProfile,
    required this.location,
    required this.intentions,
    required this.mbti,
    required this.bio,
    required this.height,
    required this.profileProgress,
    required this.interestedIn,
    required this.novaIntentions,
    required this.id,
    required this.isVerifiedPhoto,
    required this.isVerifiedVideo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      sexualOrientation: List<String>.from(json['sexual_orientation'] ?? []),
      showOrientationOnProfile: json['show_orientation_on_profile'] ?? false,
      location: json['location'] ?? '',
      intentions: json['intentions'] ?? '',
      mbti: json['mbti'] ?? '',
      bio: json['bio'] ?? '',
      height: json['height'] ?? '',
      profileProgress: json['profile_progress'] ?? 0,
      interestedIn: List<String>.from(json['interested_in'] ?? []),
      novaIntentions: List<String>.from(json['nova_intentions'] ?? []),
      id: json['id'] ?? 0,
      isVerifiedPhoto: json['is_verified_photo'] ?? false,
      isVerifiedVideo: json['is_verified_video'] ?? false,
    );
  }
}
