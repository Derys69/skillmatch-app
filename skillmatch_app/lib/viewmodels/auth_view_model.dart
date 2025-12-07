import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  AuthViewModel(this._repo);

  User? user;
  String? token;
  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _repo.login(email, password);
      token = result["token"];
      user = result["user"];
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> register(
      String name, String email, String pass, String loc, String skill) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _repo.register(name, email, pass, loc, skill);
      token = result["token"];
      user = result["user"];
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void logout() {
    token = null;
    user = null;
    notifyListeners();
  }
}
