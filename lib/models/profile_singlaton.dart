import 'dart:io';

import 'package:novatech/promptCategory.dart';

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

  bool showOrientationOnProfile = false;
  String location = '';
  String intentions = '';
  String mbti = '';
  String bio = '';
  String height = '';
  List<String> interestedIn = [];
  List<String> novaIntentions = [];
  int id = 0;
  String user_id  = "";
  bool isVerifiedPhoto = false;
  bool isVerifiedVideo = false;
  List<File> profileImages = [];

  List<PromptQuestion> promptList = [
    PromptQuestion(question: '', answer: '',index:0),
    PromptQuestion(question: '', answer: '',index:1),
    PromptQuestion(question: '', answer: '',index:2),
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
    interestedIn = [];
    novaIntentions = [];
    id = 0;
    isVerifiedPhoto = false;
    isVerifiedVideo = false;
  }
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
