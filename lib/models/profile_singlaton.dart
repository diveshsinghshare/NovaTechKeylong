import 'dart:convert';
import 'dart:io';

class ProfileSingleton {
  ProfileSingleton._internal();
  static final ProfileSingleton _instance = ProfileSingleton._internal();
  static ProfileSingleton get instance => _instance;

  String phoneNumber = "";
  String name = '';
  String dob = '';
  String gender = '';
  Set<String> sexualOrientation = {};
  Set<String> religiousBeliefs = {};
  List<String> emotionalType = [];
  Set<String> selectedInterests = {};
  Map<String, String> selectedOptions = {};

  String token = "";
  bool showOrientationOnProfile = false;
  String location = '';
  String intentions = '';
  String mbti = '';
  String bio = '';
  String height = '';
  Set<String> interestedIn = {};
  List<String> novaIntentions = [];
  int id = 0;
  String user_id  = "";
  String selfiImagePath  = "";
  String selfiVideoPath  = "";
  String linkedProfile  = "";
  String instaProfile  = "";
  bool isVerifiedPhoto = false;
  bool isVerifiedVideo = false;
  List<File> profileImages = [];

  List<PromptQuestion> promptList = [
    PromptQuestion(question: '', answer: '', index: 0),
    PromptQuestion(question: '', answer: '', index: 1),
    PromptQuestion(question: '', answer: '', index: 2),
  ];

  /// Computed property for profile completion percentage
  int get profileProgress {
    final totalFields = 10; // adjust based on how many fields you require
    int filled = 0;

    if (name.isNotEmpty) filled++;
    if (dob.isNotEmpty) filled++;
    if (gender.isNotEmpty) filled++;
    if (sexualOrientation.isNotEmpty) filled++;
    if (location.isNotEmpty) filled++;
    if (intentions.isNotEmpty) filled++;
    if (mbti.isNotEmpty) filled++;
    if (bio.isNotEmpty) filled++;
    if (height.isNotEmpty) filled++;
    if (interestedIn.isNotEmpty) filled++;

    return ((filled / totalFields) * 100).round();
  }

  /// Resets all values (useful for logout)
  void reset() {
    name = '';
    dob = '';
    gender = '';
    sexualOrientation = {};
    religiousBeliefs = {};
    emotionalType = [];
    selectedInterests = {};
    selectedOptions = {};
    showOrientationOnProfile = false;
    location = '';
    intentions = '';
    mbti = '';
    bio = '';
    height = '';
    interestedIn = {};
    novaIntentions = [];
    id = 0;
    isVerifiedPhoto = false;
    isVerifiedVideo = false;
  }

  /// Convert class → JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "dob": dob,
      "gender": gender,
      "sexual_orientation": sexualOrientation.toList(),
      "show_orientation_on_profile": showOrientationOnProfile,
      "location": location,
      "intentions": intentions,
      "mbti": mbti,
      "bio": bio,
      "height": height,
      "profile_progress": profileProgress,
      "interested_in": interestedIn.toList(),
      "nova_intentions": novaIntentions,
    };
  }

  /// Convert JSON → class
  void fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    user_id = json["user_id"] ?? "";
    name = json["name"] ?? "";
    dob = json["dob"] ?? "";
    gender = json["gender"] ?? "";
    sexualOrientation = (json["sexual_orientation"] as List?)?.map((e) => e.toString()).toSet() ?? {};
    showOrientationOnProfile = json["show_orientation_on_profile"] ?? false;
    location = json["location"] ?? "";
    intentions = json["intentions"] ?? "";
    mbti = json["mbti"] ?? "";
    bio = json["bio"] ?? "";
    height = json["height"] ?? "";
    interestedIn = (json["interested_in"] as List?)?.map((e) => e.toString()).toSet() ?? {};
    novaIntentions = (json["nova_intentions"] as List?)?.map((e) => e.toString()).toList() ?? [];
    isVerifiedPhoto = json["isVerifiedPhoto"] ?? false;
    isVerifiedVideo = json["isVerifiedVideo"] ?? false;
    selfiImagePath = json["selfiImagePath"] ?? "";
    selfiVideoPath = json["selfiVideoPath"] ?? "";
    linkedProfile = json["linkedProfile"] ?? "";
    instaProfile = json["instaProfile"] ?? "";
  }

  /// Return as JSON string
  String toJsonString() => jsonEncode(toJson());
}


class PromptQuestion {
   String question;
   String answer;
   int index;

  PromptQuestion({
    required this.question,
    required this.answer,
    required this.index,
  });
}
