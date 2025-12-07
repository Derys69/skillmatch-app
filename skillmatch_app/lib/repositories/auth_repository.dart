import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthRepository {
  static const baseUrl = "http://localhost:8080";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return {
        "token": json["access_token"],
        "user": User.fromJson(json["user"]),
      };
    } else {
      throw Exception("Login gagal: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password, String location, String mainSkill) async {

    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "location": location,
        "main_skill": mainSkill,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return {
        "token": json["access_token"],
        "user": User.fromJson(json["user"]),
      };
    } else {
      throw Exception("Register gagal: ${response.body}");
    }
  }
}
