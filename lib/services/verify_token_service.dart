import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "https://nova-dating.onrender.com";

  /// Verifies a token and returns the user data
  static Future<Map<String, dynamic>?> verifyToken(String token) async {
    final url = Uri.parse("$_baseUrl/auth/verify-token");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print("Error verifying token: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in verifyToken: $e");
      return null;
    }
  }
}
