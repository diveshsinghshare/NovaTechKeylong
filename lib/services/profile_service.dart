import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:novatech/models/profile_singlaton.dart';

class ProfileService {
  static const String baseUrl = "https://nova-dating.onrender.com";

  /// Create Profile API
  static Future<bool> createProfile(Map<String, dynamic> json) async {
    // Sign in the user with the credentia
   String token = ProfileSingleton.instance.token;
    final url = Uri.parse("$baseUrl/profile/");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(json),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Profile created: ${response.body}");
        return true;
      } else {
        print("❌ Failed: ${response.statusCode} => ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Error: $e");
      return false;
    }
  }


  static Future<bool> fetchProfile() async {
    String token = ProfileSingleton.instance.token;
    final url = Uri.parse("$baseUrl/profile/");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ProfileSingleton.instance.fromJson(data);
        print("✅ Profile fetched: ${data}");
        return true;
      } else {
        print("❌ Failed: ${response.statusCode} => ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Error: $e");
      return false;
    }
  }

}
