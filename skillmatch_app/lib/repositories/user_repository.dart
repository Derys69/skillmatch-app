import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  static const baseUrl = "http://10.0.2.2:8080";

  Future<User> getMe(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/users/me"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Gagal mengambil profil");
    }
  }

  Future<User> updateProfile(
      String token, String name, String location, String mainSkill) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/update"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "name": name,
        "location": location,
        "main_skill": mainSkill,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Gagal update profil");
    }
  }
}
